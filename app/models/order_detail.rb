class OrderDetail < ApplicationRecord
  belongs_to :book
  belongs_to :order

  delegate :name, :image, :money, to: :book, prefix: true

  scope :by_order, -> (order_id){where order_id: order_id}
  scope :top_product, -> {group(:book_id).order('sum(quantity) desc').limit(3).pluck(:book_id)}
end
