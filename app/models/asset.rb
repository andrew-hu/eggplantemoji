class Asset < ApplicationRecord
  belongs_to :user
  mount_uploader :file_upload, FileUploader

  before_save :update_asset_attributes


  def asset_params
    params.require(:asset).permit(:user_id, :uploaded_file, :folder_id, :file_size, :content_type)
  end


  belongs_to :folder

  private

  def update_asset_attributes
    if @asset.present? && asset_changed?
      self.content_type = @asset.file.content_type
      self.file_size = @asset.file.size
    end
  end
end

