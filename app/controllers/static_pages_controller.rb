class StaticPagesController < ApplicationController
  def index
    @books = StaticPagesService.new(params).excecute
  end

  # def modalbook

  # end
end
