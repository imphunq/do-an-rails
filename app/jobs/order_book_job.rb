class OrderBookJob < ApplicationJob
  queue_as :default

  def perform user, email, order, total
    carts = OrderDetail.by_order order.id
    UserMailer.send_email(user, email, carts, total).deliver_now
  end
end
