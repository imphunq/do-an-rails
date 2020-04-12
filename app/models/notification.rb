class Notification < ApplicationRecord
  belongs_to :user

  scope :order_created_at_desc, -> {order created_at: :desc}
  scope :notification_unread, ->{where read: false}

  after_create_commit :update_noti

  private

  def update_noti
    NotificationBroadcastJob.perform_later(Notification.notification_unread.count, self)
    # ActionCable.server.broadcast 'notification_channel', counter: Notification.count
  end
end
