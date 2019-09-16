class Order < ApplicationRecord
  extend Enumerize

  composed_of :delivery,
    mapping: [ %w(name name), %w(postal_code postal_code), %w(address address), %w(phone_number phone_number)]

  belongs_to :user
  has_many :order_items, dependent: :destroy

  enumerize :delivery_time,
    in: %w(8_12 12_14 14_16 16_18 18_20 20_21)

  validates :name, :postal_code, :address, :phone_number,
    :delivery_date, :delivery_time, presence: true
  validate :delivery_date_range
  validate :order_items_at_least_one

  before_save :fill_billing_amount

  def total_amount
    order_items.sum { |item| item.amount } + postage + cod_charge + tax
  end

  def build_items(src_items)
    src_items.each do |item|
      order_items.build(
        product: item.product,
        quantity: item.quantity,
        price: item.product.price)
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

  DELIVERY_START_DAY = 2
  DELIVERY_END_DAY = 13
  def self.delivery_dates(start_date)
    [*(DELIVERY_START_DAY..DELIVERY_END_DAY)].map { |x| x.business_days.after(start_date)}
  end

  private

    def delivery_date_range
      if Order.delivery_dates(Time.current.to_date).exclude?(delivery_date)
        errors.add(:delivery_date, "は期間内にしてください")
      end
    end

    def order_items_at_least_one
      if order_items.empty?
        errors[:base] << "購入する商品が空です"
      end
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
