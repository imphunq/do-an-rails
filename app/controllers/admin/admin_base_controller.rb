module Admin
  class AdminBaseController < ApplicationController
    before_action :notification
    before_action :authenticate_user!
    before_action :check_is_admin

    layout "application_admin"

    def notification
      @notifications = Notification.includes(:user).order_created_at_desc.limit(5)
    end

    private
    def check_is_admin
      if user_signed_in? && !current_user.is_admin?
        redirect_to root_path, :warning => t("not_authen")
      end
    end
  end
end
