class BooksController < ApplicationController
  def show
    @book = Book.find_by id: params[:id]
    if user_signed_in?
      @wishlist = Wishlist.find_by book_id: @book.id, user_id: current_user.id
    end
  end

  def update_visited
    @book = Book.find_by id: params[:book_id]

    @book.update_attributes visited: (@book.visited + 1)
  end

  # def modal
  #   @book = Book.find_by id: params[:book_id]
  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  # end
end
