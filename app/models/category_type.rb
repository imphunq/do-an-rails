class CategoryType < ApplicationRecord
  belongs_to :category
  belongs_to :book

  scope :by_category_ids, -> (category_ids){where category_id: category_ids}
end
