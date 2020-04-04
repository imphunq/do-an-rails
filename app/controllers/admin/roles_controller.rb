module Admin
  class RolesController < AdminBaseController
    before_action :find_role, only: %i(edit update destroy)

    def index
      @roles = Role.created_desc.page(params[:page]).per Settings.paginate.show_15
    end

    def new
      @role = Role.new
    end

    def create
      @role = Role.new role_params

      if @role.save
        flash[:success] = t ".success"
        redirect_to admin_roles_path
      else
        flash[:danger] = t ".fail"
        render :new
      end
    end

    def edit; end

    def update
      if @role.update_attributes role_params
        flash[:success] = t ".success"
        redirect_to admin_roles_path
      else
        flash[:danger] = t ".fail"
        render :edit
      end
    end

    def destroy
      @roles = Role.created_desc.page(params[:page]).per Settings.paginate.show_15

      if @role.destroy
        flash[:success] = "Destroy success"
      else
        flash[:danger] = "Destroy fail"
      end
    end

    private

    def role_params
      params.require(:role).permit :name, :description, :enable
    end

    def find_role
      @role = Role.find_by id: params[:id]
      return if @role
      flash[:danger] = t "admin.roles.create.not_found"
      redirect_to admin_roles_path
    end
  end
end
