module Admin
  class StaticPagesController < AdminBaseController
    def index
      @order_pending_count = Order.status_pending_count
      @user_count = User.count
      @visited_book = Book.sum(:visited)
      @qty_book = Book.sum(:quantity)
      date_seven_days = (Date.parse(I18n.l(Date.today-7.days))..Date.parse(I18n.l(Date.today))).to_a
      date_seven_days.map! {|b| [I18n.l(b), 0]}

      orders_seven_days_ago = Order.order_statistic_seven_days_ago.group_by {|c| c.created_at.to_date}
      orders_get = orders_seven_days_ago.map {|a,b| ([I18n.l(a), b.count])}
      @orders = (orders_get + date_seven_days).uniq(&:first).sort

      @order_status = Order.group(:status).count
    end
  end
end
