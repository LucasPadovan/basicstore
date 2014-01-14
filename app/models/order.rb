class Order < ActiveRecord::Base
  has_many :line_items, :dependent=>:destroy

  has_many :estadordens

  belongs_to :mediopago

  attr_accessible :name, :address, :email, :mediopago_id

  validates :name, :address, :email, :mediopago_id, presence: true
  validates :email, email_format: true

  before_save :assign_status
  after_commit :assign_number
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
  #todo: whatefuckisthis
  def self.buscarConEstado(o, estado)
    orden = Order.find(o)
    orden.estadordens.each do |estadorden|
      if estadorden.estado == estado
        true
        break
      end
    end
  end

  def self.buscarEstado(estado)
    ordenes = []
    op = Order.all.each do |o|
      ordenes << o if o.estadordens.last.estado == estado
    end
    ordenes
  end

  def total
    line_items.sum(&:total_price)
  end

  def cost
    line_items.sum(&:total_costo)
  end

  private

  def assign_number
    self.update_column :number, 2013 + self.id
  end

  def assign_status
    estadordens.build( estado: Estadorden::STATUSES[0] )
  end

end