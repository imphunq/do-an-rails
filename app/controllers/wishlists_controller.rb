class WishlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_book, only: %i(create destroy)

  def index
    @wishlists = Wishlist.by_user(current_user.id).includes(:book)
  end

  def create
    @wishlist = Wishlist.new user_id: current_user.id, book_id: @book.id

    if @wishlist.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
  end

  def destroy
    @wishlists = Wishlist.by_user(current_user.id).includes(:book)
    @wishlist = Wishlist.find_by id: params[:id]

    if @wishlist.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
  end

  private

  def find_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "wishlists.create.not_found"
    respond_to do |format|
      format.js {render js: "window.location='#{request.referrer}'"}
    end
  end
end
