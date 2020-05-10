module Admin
  class StatisticOrdersController < AdminBaseController
    def index
      if params[:month].present?
        days_in_month = Time.days_in_month params[:month].to_i
        order_stats = Order.where("MONTH(created_at) = #{params[:month]}").group_by_day_of_month(:created_at).count
        @orders = Hash[(1..days_in_month).collect {|x| [x, order_stats[x]]}]
      else
        month = Date.current.month
        year = Date.current.year
        days_in_month = Time.days_in_month month, year
        order_stats = Order.where("MONTH(created_at) = #{month}").group_by_day_of_month(:created_at).count
        @orders = Hash[(1..days_in_month).collect {|x| [x, "#{order_stats[x]}"]}]
      end
      respond_to do |format|
        format.js
        format.html
      end
    end
  end
end
