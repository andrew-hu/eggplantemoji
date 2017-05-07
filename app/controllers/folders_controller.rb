class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!






  # GET /folders
  def index
    @folders = current_user.folders.all
  end

  # GET /folders/1
  def show
  end

  # GET /folders/new
  def new
    @folder = current_user.folders.new
    #if there is "folder_id" param, we know that we are under a folder, thus, we will essentially create a subfolder
    if params[:folder_id] #if we want to create a folder inside another folder

      #we still need to set the @current_folder to make the buttons working fine
      @current_folder = current_user.folders.find(params[:folder_id])

      #then we make sure the folder we are creating has a parent folder which is the @current_folder
      @folder.parent_id = @current_folder.id
    end
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders

=begin

  def create
    @folder = current_user.folders.new(folder_params)

    if @folder.save
      redirect_to @folder, notice: 'Folder was successfully created.'
    else
      render :new
    end
  end

=end
  def create
    @folder = current_user.folders.new(folder_params)
    if @folder.save
      flash[:notice] = "Successfully created folder."

      if @folder.parent #checking if we have a parent folder on this one
        redirect_to browse_path(@folder.parent)  #then we redirect to the parent folder
      else
        redirect_to root_url #if not, redirect back to home page
      end
    else
      render :action => 'new'
    end
  end



  # PATCH/PUT /folders/1
  def update
    if @folder.update(folder_params)
      redirect_to @folder, notice: 'Folder was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /folders/1
  def destroy
    @folder.destroy
    redirect_to folders_url, notice: 'Folder was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def folder_params
      params.require(:folder).permit(:name, :parent_id, :user_id)
    end
end
