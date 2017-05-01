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




#this action is for viewing folders
  def browse
    #get the folders owned/created by the current_user
    @current_folder = current_user.folders.find(params[:folder_id])
    if @current_folder

      #getting the folders which are inside this @current_folder
      @folders = @current_folder.children

      #We need to fix this to show files under a specific folder if we are viewing that folder
      #@asset = current_user.assets.find(params[:id])


      #show only files under this current folder
      #@assets = @current_folder.assets.order("uploaded_file_file_name desc")
      @assets = @current_folder.assets.order("name") #test line
      render :action => "index"
    else
      flash[:error] = "Don't be cheeky! Mind your own folders!"
      redirect_to root_url
    end
  end


end