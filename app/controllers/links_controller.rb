class LinksController < ApplicationController
  before_action :authorize
  
  def index
    @links = current_user.links
  end
  
  def create
    @link = current_user.links.new(link_params)
    if @link.save
      flash[:success] = "Your link was added!"
      redirect_to links_path
    else
      flash[:alert] = @link.errors.full_messages.join(", ")
      redirect_to links_path
    end
  end
  
  def edit
    @link = Link.find(params[:id])
  end
  
  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:success] = "Link updated successfully!"
      redirect_to links_path
    else
      flash.now[:alert] = @link.errors.full_messages.join(", ")
      render :edit
    end
  end
  
  private
  
    def link_params
      params.require(:link).permit(:title, :url, :read)
    end
    
    def authorize
      unless current_user
        flash[:alert] = "Please login to view this page!"
        redirect_to login_path
      end
    end
end