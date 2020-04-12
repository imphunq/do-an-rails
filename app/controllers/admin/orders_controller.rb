module Admin
  class OrdersController < AdminBaseController
    def index
      @orders = Order.includes(:order_details, :user).order_created_at_desc.page(params[:page]).per Settings.paginate.show_15
    end

    def update
      @order = Order.find_by id: params[:id]

      if @order.update_attributes status: params[:status]
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".fail"
      end

      redirect_to admin_orders_path
    end

    def show
      @order = Order.find_by id: params[:id]
      @order_details = @order.order_details
    end
  end
end
