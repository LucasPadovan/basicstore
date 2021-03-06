class Order < ActiveRecord::Base
  #todo: fijar el producto/promocion con el precio en el momento en el que se compro
  has_many :line_items, dependent: :destroy

  has_many :estadordens

  belongs_to :payment_method

  attr_accessible :name, :address, :email, :payment_method_id

  validates :name, :address, :email, :payment_method_id, presence: true
  validates :email, email_format: true

  before_save :assign_status
  after_commit :assign_number
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total
    line_items.sum(&:total_price)
  end

  def cost
    line_items.sum(&:total_costo)
  end

  def last_state
    estadordens.last
  end

  private

  def assign_number
    self.update_column :number, 2013 + self.id
  end

  def assign_status
    estadordens.build( estado: Estadorden::STATUSES[0] )
  end

end