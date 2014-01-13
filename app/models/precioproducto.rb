class Precioproducto < ActiveRecord::Base

  belongs_to :product

  attr_accessible :preciopublico, :costo

  validates :preciopublico, :costo, numericality: { greater_than_or_equal_to: 0.01 }
  validates :costo, :preciopublico, presence: true

end
