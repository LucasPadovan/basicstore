class OrderMailer < ActionMailer::Base
  default from: 'Lucas Padovan <lucaslockon@gmail.com>'

  def received(order)
    @order = order
    
    mail to: order.email, subject: 'Confirmacion de pedido'
  end

  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Orden embarcada'
  end

  def ready(order)
    @order = order

    mail to: order.email, subject: 'Orden lista'
  end

  def delayed(order)
    @order = order

    mail to: order.email, subject: 'Orden demorada'
  end

  def cancelled(order)
    @order = order

    mail to: order.email, subject: 'Orden cancelada'
  end
end
