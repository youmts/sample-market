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
  validate :any_order_items

  after_initialize :set_default, if: :new_record?
  before_save :fill_billing_amount

  def total_amount
    order_items.sum { |item| item.amount } + postage + cod_charge + tax
  end

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

  def total_quantity
    order_items.sum { |item| item.quantity }
  end

  POSTAGE_UNIT_QTY = 5
  POSTAGE_PER_UNIT = 600
  TAX_RATE = 0.08

  def fill_billing_amount
    amount = order_items.sum { |item| item.amount}
    amount += (self.postage = total_quantity.fdiv(POSTAGE_UNIT_QTY).ceil * POSTAGE_PER_UNIT)
    amount += (self.cod_charge = calculate_cod_charge(amount))
    amount += (self.tax = (amount * TAX_RATE).floor)
    amount
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

    def any_order_items
      if order_items.empty?
        errors[:base] << "購入する商品が空です"
      end
    end

    def set_default
      # 今日は第0営業日（休日なら次の営業日を第0営業日）
      self.delivery_date ||= 2.business_days.from_now.to_date
    end

    def calculate_cod_charge(amount)
      if amount < 10_000
        300
      elsif amount < 30_000
        400
      elsif amount < 100_000
        600
      else
        1_000
      end
    end
end
