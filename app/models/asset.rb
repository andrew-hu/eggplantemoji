class Asset < ApplicationRecord
  belongs_to :user
  mount_uploader :file_upload, FileUploader
end
