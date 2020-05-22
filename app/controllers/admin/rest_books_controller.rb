module Admin
  class RestBooksController < AdminBaseController
    def index
      @rest_books = Book.select("name").group(:name).sum(:quantity)
    end
  end
end
