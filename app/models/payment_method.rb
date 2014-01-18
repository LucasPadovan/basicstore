class PaymentMethod < ActiveRecord::Base

  has_many :orders, dependent: :destroy

  before_destroy :ensure_not_used

  validates :name, :description, presence: true
  validates :name, uniqueness: true

  attr_accessible :name, :description

  scope :tipo_pago, lambda { |a|
    where('LOWER(a) LIKE ?', "#{a}%".downcase)
  }

  private
  def ensure_not_used
    if true
      return orders.empty?
    else
      errors.add(:base, 'Medio de pago en uso')
      return false
    end
  end
end
