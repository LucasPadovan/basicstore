class ProductType < ActiveRecord::Base

  has_many :habtm_products
  has_many :products, through: :habtm_products

  before_save :update_positions
  before_destroy :cant_delete_first, :ensure_not_used

  validates_uniqueness_of :name

  attr_accessible :name, :description, :position

  def to_s
    name
  end

  private
  def ensure_not_used
    unless products.empty?
      errors.add(:base, I18n.t('admin.product_types.errors.used'))
      false
    end
  end

  def cant_delete_first
    if id == 1
      errors.add(:base, I18n.t('admin.product_types.errors.first'))
      false
    end
  end

  def update_positions
    #todo: actualizar la lista de posiciones
  end
end
