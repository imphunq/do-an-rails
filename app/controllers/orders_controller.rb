class OrdersController < ApplicationController
  def index
    @orders = Order.by_user(current_user.id)
  end

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

  def show
    @order = Order.find_by id: params[:id]
    @order_details = @order.order_details
    # respond_to do |format|
    #   format.js
    #   format.html
    # end
  end

  def update
    @orders = Order.by_user(current_user.id)
    @order = Order.find_by id: params[:id]

    if @order.update_attributes status: params[:status]
      flash[:success] = "Cap nhat thanh cong"
    else
      flash[:danger] = "Cap nhat that bai"
    end
  end

  private

  def order_params
    params.require(:order).permit :phone, :address, :total
  end
end
