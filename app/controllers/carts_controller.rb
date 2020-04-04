class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_book, only: %i(create destroy update)
  skip_before_action :verify_authenticity_token

  def index
    @carts = shopping_cart
  end

  def create
    session[:carts] ||= []
    @cart_services = CartsService.new(params, @book, session[:carts], flash).perform
  end

  def destroy
    session[:carts].each do |item|
      session[:carts].delete(item) if item["book_id"] == @book.id
    end
  end

  def update
    quantity = params[:qty].to_i

    if quantity > @book.quantity
      flash[:danger] = t "quantity_invalid"
    else
      result = find_exist_book_in_cart @book.id
      result["quantity"] = quantity
      if result["quantity"] == 0
        session[:carts].delete(result)
      end
    end
  end

  def destroy_all_cart
    session[:carts] = []
  end

  private

  def find_exist_book_in_cart book_id
    result = nil
    session[:carts].each do |item|
      next unless item["book_id"] == book_id
      result = item
    end
    result
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "wishlists.create.not_found"
    respond_to do |format|
      format.js {render js: "window.location='#{request.referrer}'"}
    end
  end
end
