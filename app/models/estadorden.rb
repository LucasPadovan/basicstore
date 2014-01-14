class Estadorden < ActiveRecord::Base

  belongs_to :order
  belongs_to :user

  STATUSES = %w(Pendiente Leido Lista Entregada Cancelada Demorada)

end
