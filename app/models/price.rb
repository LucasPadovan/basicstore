class Price < ActiveRecord::Base
  after_create :update_promotion

  belongs_to :product

  attr_accessible :public_price, :cost

  validates :public_price, :cost, numericality: { greater_than_or_equal_to: 0.01 }
  validates :public_price, :cost, presence: true

  private
  def update_promotion
    product.update_promotion
  end
end
