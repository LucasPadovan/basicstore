class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, :through => :line_items
  has_many :precioproductos

  belongs_to :tipoproducto

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :titulo, :descripcion, :image_url, :presence => true
  validates :titulo, :uniqueness => true
  validates :image_url, :format =>{
    :with => %r{\.(gif|png|jpg)$}i,
    :message => 'Debe ser una direccion de una imagen GIF, PNG o JPG.'
  }

  attr_accessible :titulo, :descripcion, :image_url, :tipoproducto_id, :cantidad,

  def self.buscartipo(tipo)
    Product.where('tipoproducto_id = ?', tipo)
  end

  def self.novedades
    Product.last(5).reverse
  end

  private
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
