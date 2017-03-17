class Asset < ApplicationRecord
  belongs_to :user
  mount_uploader :file_upload, FileUploader
  def file_size
    uploaded_file_file_size
  end
end
