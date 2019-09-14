module ApplicationHelper
  def hide_information(product)
    if product.hid_at.presence
      time_ago_in_words(product.hid_at) + "前に非表示化"
    else
      ""
    end
  end
end
