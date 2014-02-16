class Estadorden < ActiveRecord::Base

  belongs_to :order
  belongs_to :user

  #todo: Enviada y Recibida como nuevos estados
  #todo: motivo de la demora, motivo de la cancelacion, mail para cada una de esas cosas.
  STATUSES = %w(Pendiente Leido Lista Entregada Cancelada Demorada)

  def pending?
    estado == STATUSES[0]
  end

  def seen?
    estado == STATUSES[1]
  end

  def ready?
    estado == STATUSES[2]
  end

  def shipped?
    estado == STATUSES[3]
  end

  def cancelled?
    estado == STATUSES[4]
  end

  def delayed?
    estado == STATUSES[5]
  end

end
