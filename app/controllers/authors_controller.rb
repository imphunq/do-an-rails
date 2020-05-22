class AuthorsController < ApplicationController
  def show
    if params[:price]
      a = params[:price].split("-")[0].gsub("\,", "")
      b = params[:price].split("-")[1].gsub("\,", "")
      @q = Book.includes(:author).by_author(params[:id]).between_price(a, b).search params[:q]
    else
      @q = Book.includes(:author).by_author(params[:id]).search params[:q]
    end
    @author = Author.find_by id: params[:id]
    @authors = Author.select(:id, :name)
    @books = @q.result(distinct: true)
    @top_books = Book.top_product
  end
end
