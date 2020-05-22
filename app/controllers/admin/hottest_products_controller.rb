module Admin
  class HottestProductsController < AdminBaseController
    def index
      @hottest_product = OrderDetail.joins(:book).select("books.name").group(:name).sum(:quantity)
    end
  end
end
