class TransactionsController < ApplicationController

  def index 
    

    if params[:scope] == 'all'
        commutes = Commute.includes(:locations) # Include location data
    else
        commutes = @current_user.commutes.includes(:locations) # Include location data
    end

    
    points_per_mode = {
      "public_transport" => 100,
      "carpooling" => 80,
      "work_from_home" => 120,
      "private_vehicle" => 20
    }

    # Initialize total points and breakdown
    total_points = 0
    breakdown = []

    commutes.each do |commute|
      mode_points = 0

      if commute.transport_mode == "work_from_home"
        # Assign fixed points for work_from_home
        mode_points += points_per_mode["work_from_home"]
      else
        # Get the first and last reported coordinates
        locations = commute.locations.order(:created_at)
        if locations.size >= 2
          from_coords = [locations.first.latitude, locations.first.longitude]
          to_coords = [locations.last.latitude, locations.last.longitude]

          # Calculate the distance in kilometers
          distance = Geocoder::Calculations.distance_between(from_coords, to_coords)

          # Calculate points based on distance and transport mode
          mode_points = (distance * points_per_mode[commute.transport_mode] / 10).round(2)
        end
      end

      # Add points for the commute to the total
      total_points += mode_points

      # Add commute details to the breakdown
      breakdown << {
        commute_id: commute.id,
        transport_mode: commute.transport_mode,
        points: mode_points,
        date: commute.created_at.strftime("%Y-%m-%d"),
        from_location: locations&.first&.attributes&.slice("latitude", "longitude"),
        to_location: locations&.last&.attributes&.slice("latitude", "longitude")
      }
    end

    # Calculate total credits
    total_credits = (total_points / 10).round(2)

    render json: {
      total_points: total_points.round(2),
      total_credits: total_credits,
      breakdown: breakdown
    }, status: :ok
  end
end
