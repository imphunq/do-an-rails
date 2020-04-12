module Admin
  class NotificationsController < AdminBaseController
    def update
      @notification = Notification.find_by id: params[:id]
      if request.xhr?
        @notification.update_attributes read: true
      end
    end
  end
end
