class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  before_save :default_row_order, if: -> () { @row_order.nil? }

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

  private

    def default_row_order
      self.row_order = 0
    end
end
