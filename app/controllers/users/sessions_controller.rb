# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    if resource.is_admin? || resource.is_staff?
      flash[:success] = t "admin.users.index.login_success"
      admin_root_path
    else
      flash[:success] = t "admin.users.index.login_success"
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    flash[:success] = t "admin.users.index.logout_success"
    root_path
  end
end
