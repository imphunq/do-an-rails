module Admin
  class AuthorsController < AdminBaseController
    before_action :load_author, only: %i(edit update destroy)

    def index
      @authors = Author.created_desc.page(params[:page]).per Settings.paginate.show_15
    end

    def new
      @author = Author.new
    end

    def create
      @author = Author.new author_params

      if @author.save
        flash[:success] = t ".success"
        redirect_to admin_authors_path
      else
        flash[:danger] = t ".fail"
        render :new
      end
    end

    def edit; end

    def update
      if @author.update_attributes author_params
        flash[:success] = t ".success"
        redirect_to admin_authors_path
      else
        flash[:danger] = t ".fail"
        render :edit
      end
    end

    def destroy
      @authors = Author.created_desc.page(params[:page]).per Settings.paginate.show_15

      if @author.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".fail"
      end
    end

    private
    def author_params
      params.require(:author).permit :name, :birthday, :description, :address, :status
    end

    def load_author
      @author = Author.find_by id: params[:id]
      return if @author
      flash[:danger] = t "admin.authors.edit.not_found"
      redirect_to admin_authors_path
    end
  end
end
