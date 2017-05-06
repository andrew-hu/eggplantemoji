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


