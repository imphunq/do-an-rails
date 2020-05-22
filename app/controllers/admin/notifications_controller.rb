module Admin
  class NotificationsController < AdminBaseController
    def index
      @notifications_all = Notification.includes(:user).order_created_at_desc.page(params[:page]).per Settings.paginate.show_20
      @notification_read = Notification.notification_read.count
      @notification_unread = Notification.notification_unread.count
    end

    def update
      @notification = Notification.find_by id: params[:id]
      if request.xhr?
        @notification.update_attributes read: true
      end
    end
  end
end
