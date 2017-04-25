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
    if user_signed_in? == true
      @asset = current_user.assets.new
    elsif user_signed_in? == false
      flash[:error1] = "Error. Try signing in or signing up to continue."
      flash[:error1]
      redirect_to "http://127.0.0.1:3000/users/sign_in"
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = current_user.assets.find(params[:id])
  end

  # POST /assets
  def create
    if(params.has_key?(:asset) == false && params.has_key?(:file_upload) == false)
      flash[:error2] = "Error. Please select a file before clicking create."
      flash[:error2]
      redirect_to "http://127.0.0.1:3000/assets/new" and return
    end
    @asset = current_user.assets.new(asset_params)

    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: 'File was successfully uploaded.' }
        format.json { render :show, status: :created, location: @asset }
      else
        format.html { render :new }
        format.json { render json: @asser.errors, status: :unprocessable_entity }
      end
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_asset
    current_user.assets.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def asset_params
    params.require(:asset).permit(:file_upload)
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
    @assets = current_user.assets.order("uploaded_file_file_name desc")

    render :action => "index"
  else
    flash[:error] = "Don't be cheeky! Mind your own folders!"
    redirect_to root_url
  end
end