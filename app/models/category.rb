class Category < ApplicationRecord
  has_many :category_types
  has_many :books, through: :category_types

  validates :name, presence: true, length: {maximum: Settings.max_length_category_name}

  scope :created_desc, ->{order created_at: :desc}

  def enable_status_i18n
    I18n.t("admin.categories.index.status_work.#{status}")
  end
end
