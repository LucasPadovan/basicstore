class Precioproducto < ActiveRecord::Base

  belongs_to :product

  validates :preciopublico, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :costo, :numericality => {:greater_than_or_equal_to => 0.01}

  validates_presence_of :costo
  validates_presence_of :preciopublico

end
