class Author < ApplicationRecord
  has_many :books

  validates :name, presence: true, length: {maximum: Settings.max_length_category_name}

  scope :created_desc, ->{order created_at: :desc}
  scope :hot_author, ->{where id: Book.hot_author_id}

  def enable_status_i18n
    I18n.t("admin.authors.index.status_work.#{status}")
  end
end
