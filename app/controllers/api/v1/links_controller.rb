class Api::V1::LinksController < ApplicationController
  
  def update
    @link = Link.find(params[:id])
    @link.update(read: params[:status])
  
    render json: @link
  end
end