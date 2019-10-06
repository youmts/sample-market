class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

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
      "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  private

    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
    end
end
