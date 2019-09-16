class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_limit: [1200, 900]

  version :thumb do
    process resize_to_limit: [200, 150]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.jpg" if original_filename.present?
  end
end
