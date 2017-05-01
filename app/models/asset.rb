class Asset < ApplicationRecord
  belongs_to :user
  mount_uploader :file_upload, FileUploader
  def file_size
    uploaded_file_file_size
  end



  def asset_params
    params.require(:asset).permit(:user_id, :uploaded_file, :folder_id)
  end


  #need to be fixed
  #attr_accessible :user_id, :uploaded_file, :folder_id


  belongs_to :folder

end

