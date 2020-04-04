class CartsService

  def initialize params, book, cart, flash
    @params = params
    @book = book
    @cart = cart
    @flash = flash
  end

  def perform
    create_cart
  end

  private

  def create_cart
    order_detail = OrderDetail.new book_id: @params[:id], quantity: @params[:qty], money: @params[:price]
    result = find_exist_book_in_cart order_detail.book_id
    if @book.quantity == 0
      @flash.now[:danger] = I18n.t("sold_out")
    elsif order_detail.quantity > @book.quantity
      @flash.now[:danger] = I18n.t("quantity_invalid", quantity: @book.quantity)
    elsif result
      if (result["quantity"] + order_detail.quantity) > @book.quantity
        @flash.now[:danger] = I18n.t("sold_out")
      else
        result["quantity"] = result["quantity"] + order_detail.quantity
      end
    else
      @cart << order_detail.as_json
    end
  end

  def find_exist_book_in_cart book_id
    result = nil
    @cart.each do |item|
      next unless item["book_id"] == book_id
      result = item
    end
    result
  end
end
