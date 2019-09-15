class Order < ApplicationRecord
  extend Enumerize

  composed_of :delivery,
    mapping: [ %w(name name), %w(postal_code postal_code), %w(address address), %w(phone_number phone_number)]

  belongs_to :user
  has_many :order_items, dependent: :destroy

  enumerize :delivery_time,
    in: %w(8_12 12_14 14_16 16_18 18_20 20_21), default: "8_12"

  validates :name, :postal_code, :address, :phone_number,
    :delivery_date, :delivery_time, presence: true
  validate :delivery_date_range

  after_initialize :set_default, if: :new_record?

  def build_items(user)
    user.cart_items.each do |cart_item|
      order_items.build(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price)
    end
  end

  def update_user_delivery!
    user.delivery = self.delivery
    user.save!
  end

  private
    def delivery_date_range
      # 今日は第0営業日（休日なら次の営業日を第0営業日）
      start_date = 2.business_days.from_now.to_date
      end_date = 13.business_days.from_now.to_date

      if (start_date..end_date).exclude?(delivery_date)
        errors.add(:delivery_date, "は期間内にしてください")
      end
    end

    def set_default
      # 今日は第0営業日（休日なら次の営業日を第0営業日）
      self.delivery_date ||= 2.business_days.from_now.to_date
    end
end
