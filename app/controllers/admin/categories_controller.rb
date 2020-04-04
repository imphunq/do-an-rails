module Admin
  class CategoriesController < AdminBaseController
    before_action :find_category, only: %i(destroy edit show update)

    def index
      @categories = Category.created_desc.page(params[:page]).per Settings.paginate.show_15
    end

    def new
      @category = Category.new
    end

    def edit; end

    def update
      if @category.update_attributes category_params
        flash[:success] = t ".update_success"
        redirect_to admin_categories_path
      else
        flash[:danger] = t ".update_failed"
        render :edit
      end
    end

    def show; end

    def create
      @category = Category.new category_params

      if @category.save
        flash[:success] = t ".create_success"
        redirect_to admin_categories_path
      else
        flash[:danger] = t ".create_fail"
        render :new
      end
    end

    def destroy
      @categories = Category.created_desc.page(params[:page]).per Settings.paginate.show_15
      if @category.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".failed"
      end
    end

    private

    def category_params
      params.require(:category).permit :name, :description, :status
    end

    def find_category
      @category = Category.find_by id: params[:id]
      return if @category
      flash[:danger] = "Khong tim thay the loai nay"
      redirect_to admin_categories_path
    end
  end
end
