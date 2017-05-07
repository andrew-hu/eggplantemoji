class AssetsController < ApplicationController
  before_action :authenticate_user!,:set_asset, only: [:show, :edit, :update, :destroy]
  # GET /assets
  def index
    if user_signed_in? == true
      @assets = current_user.assets

      #load current_user's folders
      @folders = current_user.folders.order("name desc")
    elsif user_signed_in? == false
      flash[:error1] = "Error. Try signing in or signing up to continue."
      flash[:error1]
      redirect_to "http://127.0.0.1:3000/users/sign_in"
    end
  end

  # GET /assets/1
  def show
    @asset = current_user.assets.find(params[:id])
  end

  # GET /assets/new


  def new
    @asset = current_user.assets.build
    if params[:folder_id] #if we want to upload a file inside another folder
      @current_folder = current_user.folders.find(params[:folder_id])
      @asset.folder_id = @current_folder.id
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = current_user.assets.find(params[:id])
  end

  # POST /assets



  def create

    @asset = current_user.assets.build(asset_params)
    if @asset.save
      flash[:notice] = "Successfully uploaded the file."

      if @asset.folder #checking if we have a parent folder for this file
        redirect_to browse_path(@asset.folder)  #then we redirect to the parent folder
      else
        redirect_to root_url
      end
    else
      render :action => 'new'
    end
  end

  # PATCH/PUT /assets/1
  def update
    if(params.has_key?(:asset) == false && params.has_key?(:file_upload) == false)
      flash[:error3] = "Error. Please select a file before clicking update."
      flash[:error3]
      redirect_to "http://127.0.0.1:3000/assets/" and return
    end
    @asset = current_user.assets.find(params[:id])
    respond_to do |format|
      if @asset.update(asset_params)
        format.html { redirect_to @asset, notice: 'File was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset }
      else
        format.html { render :edit }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  def destroy
    @asset = current_user.assets.find(params[:id])
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to assets_url, notice: 'File was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  #this handles ajax request for inviting others to share folders
  def share
    #first, we need to separate the emails with the comma
    email_addresses = params[:email_addresses].split(",")

    email_addresses.each do |email_address|
      #save the details in the ShareFolder table
      @shared_folder = current_user.shared_folders.new
      @shared_folder.folder_id = params[:folder_id]
      @shared_folder.shared_email = email_address

      #getting the shared user id right the owner the email has already signed up with ShareBox
      #if not, the field "shared_user_id" will be left nil for now.
      shared_user = User.find_by_email(email_address)
      @shared_folder.shared_user_id = shared_user.id if shared_user

      @shared_folder.message = params[:message]
      @shared_folder.save

      #now we need to send email to the Shared User
    end

    #since this action is mainly for ajax (javascript request), we'll respond with js file back (refer to share.js.erb)
    respond_to do |format|
      format.js {
      }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_asset
    current_user.assets.find(params[:id])
  end
  # Only allow a trusted parameter "white list" through.
  def asset_params
    params.require(:asset).permit(:user_id, :file_upload, :folder_id)
  end


end


