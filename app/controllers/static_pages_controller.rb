class StaticPagesController < ApplicationController
  def index
    @books = StaticPagesService.new(params).excecute
    @top_books = Book.top_product
  end

  # def modalbook

  # end
end
