module Admin
  class AdminBaseController < ApplicationController
    layout "application_admin"
    before_action :notification

    def notification
      @notifications = Notification.includes(:user).order_created_at_desc.limit(5)
    end
  end
end
