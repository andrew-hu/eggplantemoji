class HomeController < ApplicationController
  def index
    if user_signed_in?
      @assets = current_user.assets.order("uploaded_file_file_name desc")

      #load current_user's folders
      @folders = current_user.folders.order("name desc")
    end
  end
end