class Author < ApplicationRecord
  validates :name, presence: true, length: {maximum: Settings.max_length_category_name}

  scope :created_desc, ->{order created_at: :desc}

  def enable_status_i18n
    I18n.t("admin.authors.index.status_work.#{status}")
  end
end
