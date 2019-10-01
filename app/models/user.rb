class User < ApplicationRecord
  composed_of :delivery, mapping: [ %w(name name), %w(postal_code postal_code), %w(address address), %w(phone_number phone_number)]

  has_many :cart_items, -> { order :created_at }, dependent: :destroy
  has_many :orders, dependent: :nullify
  has_many :identities, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(google_oauth2)

  def self.from_omniauth(auth)
    uid = auth.uid
    joins(:identities).where(:identities => { uid: uid, provider: :google_oauth2 }).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.identities.build(uid: uid, provider: :google_oauth2)
    end
  end

  def add_cart!(product)
    item = cart_items.find_or_initialize_by(product_id: product.id)
    item.quantity += 1
    item.save!
    item.quantity
  end

  def remove_cart!(product)
    item = cart_items.find_by(product_id: product.id)
    item.quantity -= 1

    if item.quantity == 0
      item.destroy!
    else
      item.save!
    end
    item.quantity
  end

  def cart_total_amount
    cart_items.sum { |item| item.quantity * item.product.price }
  end
end
