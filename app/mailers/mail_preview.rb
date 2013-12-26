class MailPreview < MailView

  def order_received
    OrderMailer.received(Order.last)
  end

  def order_shipped
    OrderMailer.shipped(Order.last)
  end

  def order_ready
    OrderMailer.ready(Order.last)
  end

  def order_delayed
    OrderMailer.delayed(Order.last)
  end

  def order_cancelled
    OrderMailer.cancelled(Order.last)
  end

end