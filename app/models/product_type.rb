class ProductType < ActiveRecord::Base

  has_many :products

  before_destroy :verificar_no_uso

  validates_uniqueness_of :name

  attr_accessible :name, :description, :position

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
