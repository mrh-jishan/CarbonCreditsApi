class AnalyticsController < ApplicationController

  def index

    if params[:scope] == "all"
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

    # Calculate total points and breakdown
    total_points = 0
    total_commutes = commutes.size
    breakdown = {}

    commutes.group_by(&:transport_mode).each do |mode, grouped_commutes|
      mode_points = 0

      grouped_commutes.each do |commute|

        if mode == "work_from_home"
          # Assign fixed points for work_from_home
          mode_points += points_per_mode[mode]
        else
          # Get the first and last reported coordinates
          locations = commute.locations.order(:created_at)
          if locations.size >= 2
            from_coords = [locations.first.latitude, locations.first.longitude]
            to_coords = [locations.last.latitude, locations.last.longitude]

            # Calculate the distance in kilometers
            distance = Geocoder::Calculations.distance_between(from_coords, to_coords)


            # puts "----------------------------------points_per_mode[mode]: #{points_per_mode[mode]} for distance: #{distance}"

            # Calculate points based on distance and transport mode
            distance_points = (distance * points_per_mode[mode]/10).round(2)

            # puts "----------------------------------distance_points: #{distance_points} for mode: #{mode}"

            # Add points for the commute
            mode_points += distance_points
          end
        end
      end

      # puts "----------------------------------mode_points: #{mode_points} for mode: #{mode}"

      percentage = ((grouped_commutes.size.to_f / total_commutes) * 100).round(2)

      breakdown[mode] = {
        count: grouped_commutes.size,
        points: mode_points,
        percentage: percentage
      }

      total_points += mode_points
    end

    # Calculate total credits
    total_credits = total_points / 10

    render json: {
      total_points: total_points,
      total_credits: total_credits.round(2),
      breakdown: breakdown
    }, status: :ok
  end

end
