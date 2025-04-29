class LocationsController < ApplicationController

  before_action :set_commute, only: [:create]

  def create
    @location = @commute.locations.new(location_params)

    if @location.save
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end 



  protected

  def location_params
    params.require(:location).permit(:latitude, :longitude, :speed)
  end

  private

  def set_commute
    @commute = @current_user.commutes.find(params[:commute_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Commute not found' }, status: :not_found
  end


end
