class CategoriesController < ApplicationController
  def show
    if params[:price]
      a = params[:price].split("-")[0].gsub("\,", "")
      b = params[:price].split("-")[1].gsub("\,", "")
      @q = Book.includes(:categories).by_category(params[:id]).between_price(a, b).search params[:q]
    else
      @q = Book.includes(:categories).by_category(params[:id]).search params[:q]
    end
    @categories = Category.select(:id, :name)
    @category = Category.find_by id: params[:id]
    @books = @q.result(distinct: true)
    @top_books = Book.top_product
  end
end
