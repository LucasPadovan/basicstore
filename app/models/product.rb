class Product < ActiveRecord::Base
  
  default_scope :order => 'titulo'
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  has_many :orders, :through => :line_items

  belongs_to :tipoproducto

  has_many :precioproductos
  
  validates :titulo, :descripcion, :image_url, :presence => true
  validates :titulo, :uniqueness => true
  validates :image_url, :format =>{
    :with => %r{\.(gif|png|jpg)$}i,
    :message => 'Debe ser una direccion de una imagen GIF, PNG o JPG.'
  }

  def self.buscartipo(tipo)
    product = Product.where('tipoproducto_id = ?', tipo)
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
