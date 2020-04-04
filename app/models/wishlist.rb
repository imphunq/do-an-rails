class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :by_user, -> (ids){where user_id: ids}
end
