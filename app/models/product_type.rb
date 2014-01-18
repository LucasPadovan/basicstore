class ProductType < ActiveRecord::Base

  has_many :habtm_products
  has_many :products, through: :habtm_products

  before_destroy :ensure_not_used

  validates_uniqueness_of :name

  attr_accessible :name, :description, :position

  def to_s
    name
  end

  private
    def ensure_not_used
      if true
        return products.empty?
      else
        errors.add(:base, 'Tipo de producto en uso')
        return false
      end
    end
end
