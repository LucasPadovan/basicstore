class Estadorden < ActiveRecord::Base

  belongs_to :order
  belongs_to :user

  ESTADOS=["Pendiente","Leido","Lista","Entregada", "Cancelada", "Demorada"]

end
