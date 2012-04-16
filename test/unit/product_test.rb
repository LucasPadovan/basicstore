require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  
  test "los atributos del producto no deben estar vacios" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:titulo].any?
    assert product.errors[:descripcion].any?
    assert product.errors[:precio].any?
    assert product.errors[:image_url].any?
  end
  
  test "el precio del producto debe ser positivo" do
    product = Product.new(:titulo => 'Plantilla 1', :descripcion => 'una descripcion detallada',
      :image_url=> 'url1.jpg')
    
    product.precio =-1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:precio].join(';')
      
    product.precio =0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:precio].join(';')
    
    product.precio=1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(:titulo => 'Plantilla 1', :descripcion => 'una descripcion detallada',
      :precio => 1, :image_url => image_url)
  end
  
  test "image url" do
    ok= %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |name|
      assert new_product(name).valid?, "#{name} no deberia ser invalido"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} no deberia ser valido"
    end
  end
  
  test "los productos no son validos sin nombre unico" do
    product = Product.new(:titulo => products(:ruby).titulo, :descripcion => "una descripcion",
      :precio => 1, :image_url => "url2.jpg")
    assert !product.save
    assert_equal "no se encuentra disponible", product.errors[:titulo].join('; ')
  end
  
  test "los productos no son validos sin nombre unico - i18n" do
    product = Product.new(:titulo => products(:ruby).titulo, :descripcion => "una descripcion",
      :precio => 1, :image_url => "url2.jpg")
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'),
      product.errors[:titulo].join('; ')
  end
end
