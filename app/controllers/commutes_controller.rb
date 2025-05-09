class CommutesController < ApplicationController

  def create
    @commute = @current_user.commutes.new(commute_params)

    if @commute.save
      render json: @commute, status: :created, location: @commute
    else
      render json: @commute.errors, status: :unprocessable_entity
    end
  end


  def index
    @commutes = @current_user.commutes.includes(:location)
    render json: @commutes.as_json(include: :location), status: :ok
  end

  protected


  def commute_params
    params.require(:commute).permit(:transport_mode, :from_location, :to_location)
  end
end
