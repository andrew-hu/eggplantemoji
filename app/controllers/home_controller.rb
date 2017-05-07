class HomeController < ApplicationController
  def index
    if user_signed_in?
      #show only root folders (which have no parent folders)
      @folders = current_user.folders.roots

      #show only root files which has no "folder_id"
      @assets = current_user.assets.where("folder_id is NULL").order("name")
    else
      render :layout => false
    end
  end







end