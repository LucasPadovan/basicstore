class OrderMailer < ActionMailer::Base
  default from: 'Lucas Padovan <lucaslockon@gmail.com>'
  layout 'mail'

  #todo: definir cual de estos se queda
  def received(order)
    @order = order
    
    mail to: order.email, subject: 'Confirmacion de pedido', content_type: 'text/html'
  end

  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Orden embarcada', content_type: 'text/html'
  end

  def ready(order)
    @order = order

    mail to: order.email, subject: 'Orden lista', content_type: 'text/html'
  end

  def delayed(order)
    @order = order

    mail to: order.email, subject: 'Orden demorada', content_type: 'text/html'
  end

  def cancelled(order)
    @order = order

    mail to: order.email, subject: 'Orden cancelada', content_type: 'text/html'
  end
end
