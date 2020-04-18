class Book < ApplicationRecord
  belongs_to :author
  has_many :category_types, dependent: :destroy
  has_many :categories, through: :category_types, source: :category
  has_many :wishlists, dependent: :destroy

  mount_uploader :image, BookImageUploader

  validates :name, presence: true, length: {maximum: Settings.max_length_category_name}
  validates :description, presence: true
  validates :money, presence: true
  validates :quantity, presence: true

  accepts_nested_attributes_for :category_types, allow_destroy: true

  scope :created_desc, ->{order created_at: :desc}
  scope :price_desc, ->{order money: :desc}
  scope :price_asc, ->{order money: :asc}
  scope :visited_desc, ->{order visited: :desc}
  scope :by_category, ->(category_ids){joins(:category_types).where(category_types: {category_id: category_ids})}
  scope :between_price, -> (price1, price2){where('money between ? and ?', price1, price2)}

  def enable_status_i18n
    I18n.t("admin.authors.index.status_work.#{status}")
  end

  def wishlist_by_user? user
    wishlists.by_user(user.id).any?
  end
end
