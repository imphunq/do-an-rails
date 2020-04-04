class CategoriesController < ApplicationController
  def show
    @categories = Category.select(:id, :name)
    @category = Category.find_by id: params[:id]
    @books = Book.by_category params[:id]
  end
end
