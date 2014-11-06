class ConfirmedMatchesController < ApplicationController
  def index
    render json: ConfirmedMatch.all
  end
  
  def create
    params.require(:confirmed_match).permit!
    render json: {}
  end
end
