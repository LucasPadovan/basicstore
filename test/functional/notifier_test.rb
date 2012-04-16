require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    mail = Notifier.order_received(orders(:one))
    assert_equal "Confirmacion de pedido", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["lucaslockon@gmail.com"], mail.from
#    assert_match "Dear MyString Complete\r\nThank, you for your order.\r\nYou ordered:\r\nWe'll send you a separate e.mail when your order ships.", mail.body.encoded
    assert_match "Dear MyString Complete\r\nThank, you for your order.\r\nYou ordered:\r\n\r\n1 x programando en ruby 1.9 = $49.50\r\nTotal de la compra: $49.50\r\nWe'll send you a separate e.mail when your order ships.", mail.body.encoded
  end

  test "order_shipped" do
    mail = Notifier.order_received(orders(:one))
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["lucaslockon@gmail.com"], mail.from
    assert_match "Dear MyString Complete\r\nThank, you for your order.\r\nYou ordered:\r\n\r\n1 x programando en ruby 1.9 = $49.50\r\nTotal de la compra: $49.50\r\nWe'll send you a separate e.mail when your order ships.", mail.body.encoded
  end

end
