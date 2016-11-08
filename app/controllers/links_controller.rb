class LinksController < ApplicationController
  before_action :authorize
  attr_reader :email
  
  def index
    @links = current_user.links
  end
  
  def create
    @link = current_user.links.new(link_params)
    if @link.save
      flash[:success] = "Your link was added!"
      send_email?
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
      user_input = params.require(:link).permit(:title, :url, :read)
      if user_input["url"].include?("\\")
        @email = user_input[:url].split("\\").second.split("cc:").second.strip
        user_input["url"] = user_input[:url].split("\\").first.strip
      end
      user_input
    end
    
    def authorize
      unless current_user
        flash[:alert] = "Please login to view this page!"
        redirect_to login_path
      end
    end
    
    def send_email?
      if @email
        require "pry"
        binding.pry
        NotifierMailer.link_notify(@link.url, @email).deliver_now
        flash[:success] = "Your link was added and the email was sent!"
      end
    end
end