class PaymentMethod < ActiveRecord::Base

  has_many :orders

  before_destroy :referenced_in_order?

  validates :name, :description, presence: true
  validates :name, uniqueness: true

  attr_accessible :name, :description

  private
  def referenced_in_order?
    if orders.any?
      errors.add(:base, I18n.t('admin.payment_methods.errors.referenced_in_order'))
      false
    end
  end
end
