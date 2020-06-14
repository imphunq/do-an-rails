class OrderDetail < ApplicationRecord
  belongs_to :book
  belongs_to :order

  delegate :name, :image, :money, to: :book, prefix: true

  scope :by_order, -> (order_id){where order_id: order_id}
  scope :top_product, -> {group(:book_id).order('sum(quantity) desc').limit(3).pluck(:book_id)}

  after_save :update_quantity_product

  private
  def update_quantity_product
    book.update quantity: (book.quantity - quantity.to_i)
  end
end
