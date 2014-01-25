class Precioproducto < ActiveRecord::Base
  after_create :update_promotion

  belongs_to :product

  attr_accessible :preciopublico, :costo

  validates :preciopublico, :costo, numericality: { greater_than_or_equal_to: 0.01 }
  validates :costo, :preciopublico, presence: true

  private
  def update_promotion
    product.update_promotion
  end
end
