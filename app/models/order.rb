class Order < ActiveRecord::Base
  has_many :line_items, :dependent=>:destroy

  has_many :estadordens

  belongs_to :mediopago
  validates :name, :address, :email,:mediopago, :presence=>true
  validates :email,:email_format => true

  attr_accessor :auto_mediopago
  before_validation :asignar_mediopago
  
  scope :cheques, where(:mediopago_id=>1)
  scope :efectivo, where(:mediopago_id=>2)
  scope :tarjetaC, where(:mediopago_id=>3)
  scope :tarjetaD, where(:mediopago_id=>4)  
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
  def asignar_mediopago
    if self.auto_mediopago.present?
      self.mediopago = Mediopago.find_by_nombre(
        self.auto_mediopago
      )
    end
  end

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
end