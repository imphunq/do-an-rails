class Order < ApplicationRecord
  after_create_commit :notify
  after_update :refuse_notify

  has_many :order_details, dependent: :destroy
  belongs_to :user

  enum status: {pending: 0, accept: 1, refuse: 2}

  scope :order_created_at_desc, -> {order created_at: :desc}
  scope :status_pending_count, ->{where(status: :pending).count}
  scope :order_statistic_seven_days_ago, ->{where.not(status: :refuse).where("created_at >= ?", Date.today-7.days)}
  scope :by_user, -> (ids){where user_id: ids}

  def enable_status_i18n
    I18n.t("admin.orders.index.status_work.#{status}")
  end

  private

  def notify
    Notification.create messages: I18n.t(".order_noti", user: user.name), user_id: user_id
  end

  def refuse_notify
    Notification.create(messages: I18n.t(".update_noti", user: user.name), user_id: user_id) if self.refuse?
  end
end
