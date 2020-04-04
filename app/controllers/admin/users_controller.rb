module Admin
  class UsersController < AdminBaseController
    before_action :load_user, only: %i(edit update destroy)

    def index
      @users = User.created_desc.page(params[:page]).per Settings.paginate.show_15
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new user_params

      if @user.save
        flash[:success] = t ".success"
        redirect_to admin_users_path
      else
        flash[:danger] = t ".fail"
        render :new
      end
    end

    def edit; end

    def update
      if @user.update_attributes user_params
        flash[:success] = t ".success"
        redirect_to admin_users_path
      else
        flash[:danger] = t ".fail"
        render :edit
      end
    end

    def destroy
      @users = User.created_desc.page(params[:page]).per Settings.paginate.show_15

      if @user.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".fail"
      end
    end

    private

    def user_params
      params.require(:user).permit :name, :email, :avatar, :staff_type,
                                   :gender, :birthday, :phone
    end

    def load_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:danger] = t "admin.users.index.not_found"
      redirect_to admin_users_path
    end
  end
end
