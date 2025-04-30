class ApplicationController < ActionController::API
  include Clerk::Authenticatable
  before_action :require_clerk_session!
  # before_action :require_reverification!

  
  protected

  # If the user is not authenticated, redirect to the sign-in page
  def require_clerk_session!
    session_token = request.headers["Authorization"]&.split("Bearer ")&.last

    unless session_token
      render json: { error: "Unauthorized: No session token provided" }, status: :unauthorized
      return
    end
    
    # puts "Session token-----------: #{session_token}"

    clerk = Clerk::SDK.new

    begin
      @clerk_session =  clerk.verify_token(session_token)

      @current_user = User.find_or_initialize_by(clerk_user_id: @clerk_session['sub'])

      if @current_user.new_record?
        @current_user.save
      end
  
      @current_user

    rescue Clerk::Errors::BaseError => e
      render json: { error: "Unauthorized: #{e.message}" }, status: :unauthorized
      return
    end
  end
  
end
