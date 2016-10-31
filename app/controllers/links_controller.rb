class LinksController < ApplicationController
  
  def index
    @links = current_user.links
  end
  
  def create
  end
  
  private
  
    def link_params
      params.require(:link).permit(:title, :url, :read)
    end
end