class Product < ApplicationRecord
  acts_as_list column: :row_order
  mount_uploader :image, ImageUploader

  has_many :order_items # 存在していたら削除NG

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  def hide
    self.hid_at.present?
  end

  def hide=(value)
    if ActiveRecord::Type::Boolean.new.cast(value)
      # すでに非表示の場合は上書きしないように
      if self.hid_at.nil?
        self.hid_at = Time.current
      end
    else
      self.hid_at = nil
    end
  end
end
