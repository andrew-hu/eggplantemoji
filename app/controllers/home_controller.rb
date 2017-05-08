class HomeController < ApplicationController
  def index
    if user_signed_in?

      @being_shared_folders = current_user.shared_folders_by_others
      #show only root folders (which have no parent folders)
      @folders = current_user.folders.roots

      #show only root files which has no "folder_id"
      @assets = current_user.assets.where("folder_id is NULL").order("name")
    else
      render :layout => false
    end
  end




#this action is for viewing folders
  def browse
    #first find the current folder within own folders
    @current_folder = current_user.folders.find_by_id(params[:folder_id])
    @is_this_folder_being_shared = false if @current_folder #just an instance variable to help hiding buttons on View

    #if not found in own folders, find it in being_shared_folders
    if @current_folder.nil?
      folder = Folder.find_by_id(params[:folder_id])

      @current_folder ||= folder if current_user.has_share_access?(folder)
      @is_this_folder_being_shared = true if @current_folder #just an instance variable to help hiding buttons on View

    end

    if @current_folder
      #if under a sub folder, we shouldn't see shared folders
      @being_shared_folders = []

      #show folders under this current folder
      @folders = @current_folder.children

      #show only files under this current folder
      @assets = @current_folder.assets #.order("uploaded_file_file_name desc")

      render :action => "index"
    else
      flash[:error] = "Don't be cheeky! Mind your own assets!"
      redirect_to root_url
    end
  end


end