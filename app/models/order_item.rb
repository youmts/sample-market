class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def amount
    self.price * self.quantity
  end
end
