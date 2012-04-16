class Mediopago < ActiveRecord::Base
  validates :nombre, :descripcion, :presence=>true
  validates :nombre, :uniqueness=> true
  has_many :orders, :dependent=> :destroy
  
  scope :tipo_pago, lambda { |a|
    where('LOWER(a) LIKE ?', "#{a}%".downcase)
  }

  before_destroy :verificar_no_uso

    private
      def verificar_no_uso
        if true
          return orders.empty?
        else
          errors.add(:base, 'Medio de pago en uso')
          return false
        end
      end
end
