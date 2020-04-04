class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :user

  enum status: {pending: 0, accept: 1, refuse: 2}

  scope :order_created_at_desc, -> {order created_at: :desc}

  def enable_status_i18n
    I18n.t("admin.orders.index.status_work.#{status}")
  end
end
