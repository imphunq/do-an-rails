module Admin
  class BooksController < AdminBaseController
    before_action :load_book, only: %i(edit update destroy)

    def index
      @books = Book.created_desc.page(params[:page]).per Settings.paginate.show_15
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new book_params.merge(category_types_attributes: category_type_params)
      if @book.save
        flash[:success] = t ".success"
        redirect_to admin_books_path
      else
        flash[:danger] = t ".fail"
        render :new
      end
    end

    def edit; end

    def update
      if @book.update_attributes book_params.merge(category_types_attributes: category_type_delete)
        flash[:success] = t ".success"
        redirect_to admin_books_path
      else
        flash[:danger] = t ".fail"
        render :edit
      end
    end

    def destroy
      @books = Book.created_desc.page(params[:page]).per Settings.paginate.show_15

      if @book.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".fail"
      end
    end
    private

    def book_params
      params.require(:book).permit :name, :image, :description, :author_id, :money, :quantity,
                                   :publisher, :version
    end

    def category_type_params
      category_types = {}
      params[:book][:category_ids].reject(&:blank?).each do |category_id|
        category_types["#{category_types.size}"] = {category_id: category_id, _destroy: false}
      end
      category_types
    end

    def category_type_delete
      category_types_delete = {}

      existed_category_ids = @book.category_ids
      category_ids = params[:book][:category_ids].reject(&:blank?).map(&:to_i)
      new_category = category_ids - existed_category_ids
      deleted_category = existed_category_ids - category_ids
      if new_category.any?
        new_category.each do |category_id|
          category_types_delete["#{category_types_delete.size}"] = {category_id: category_id, _destroy: false}
        end
      end

      if deleted_category.any?
        @book.category_types.by_category_ids(deleted_category).each do |category_type|
          category_types_delete["#{category_types_delete.size}"] = {id: category_type.id, _destroy: true}
        end
      end

      category_types_delete
    end

    def load_book
      @book = Book.find_by id: params[:id]
      return if @book
      flash[:danger] = t ".not_found"
      redirect_to admin_books_path
    end
  end
end
