class Notifier < ActionMailer::Base
  default :from => 'Lucas Padovan <lucaslockon@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order=order
    
    mail to: order.email, subject: 'Confirmacion de pedido'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order=order

    mail :to => order.email, :subject => 'Orden embarcada'
  end

  def order_ready(order)
    @order = order

    mail :to => order.email, :subject => 'Orden lista'
  end

  def order_delayed(order)
    @order = order

    mail :to => order.email, :subject => 'Orden demorada'
  end

  def order_canceled(order)
    @order = order

    mail :to => order.email, :subject => 'Orden cancelada'
  end
end
