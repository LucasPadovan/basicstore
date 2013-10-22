class ProductType < ActiveRecord::Base

  has_many :habtm_products
  has_many :products, through: :habtm_products

  before_destroy :verificar_no_uso

  validates_uniqueness_of :name

  attr_accessible :name, :description, :position

  def to_s
    name
  end

  private
    def verificar_no_uso
      if true
        return products.empty?
      else
        errors.add(:base, 'Tipo de producto en uso')
        return false
      end
    end
end
