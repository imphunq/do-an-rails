class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build order_params
    email = params[:email]
    total = total_price
    session[:carts].each do |item|
      @order.order_details.new item
    end

    if @order.save
      flash[:success] = t "order_success"
      # OrderBookJob.set(wait: 2.minutes).perform_later(current_user, email, cart)
      OrderBookJob.set(wait: 2.minutes).perform_later current_user, email, @order, total
      session[:carts] = []
    else
      flash[:danger] = t "order_fail"
    end
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit :phone, :address, :total
  end
end
