class FileUploader < CarrierWave::Uploader::Base

  process :save_content_type_and_size

  def save_content_type_and_size
    model.content_type = file.content_type if file.content_type
    model.file_size = file.size
  end

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #  "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #   'default_avatar.png' #rails will look at 'app/assets/images/default_avatar.png'
     #"/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :show, :if => :image? do
    process resize_to_fit: [1000,600]
  end
  version :thumb_large, from_version: :show, :if => :image? do
    process resize_to_fit: [80,80]
  end
  version :thumb_small, from_version: :thumb_large, :if => :image? do
     process resize_to_fit: [25, 25]
   end

def image?(new_file)
  defined? new_file.content_type.include? and new_file.content_type.include? 'image'
end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
