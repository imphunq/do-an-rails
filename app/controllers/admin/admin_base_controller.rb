module Admin
  class AdminBaseController < ApplicationController
    before_action :notification

    layout "application_admin"

    def notification
      @notifications = Notification.includes(:user).order_created_at_desc.limit(5)
    end
  end
end
