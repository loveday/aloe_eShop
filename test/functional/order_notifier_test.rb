require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Loveday & Yulia eStore Order Confirmation", mail.subject
    assert_equal ["info@example.org"], mail.to
    assert_equal ["aloe@example.com"], mail.from
    assert_match /1 x Aloe Berry Nectar/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Loveday & Yulia eStore Order Shipped", mail.subject
    assert_equal ["info@example.org"], mail.to
    assert_equal ["aloe@example.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Aloe Berry Nectar<\/td>/,
                 mail.body.encoded
  end

end
