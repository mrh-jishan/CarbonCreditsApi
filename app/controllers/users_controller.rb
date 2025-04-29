class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    organization_memberships = Clerk::SDK.new.organization_memberships
    list_organization_memberships = organization_memberships.list_organization_memberships('org_2vLMkZCAXOv6VCUPj24tb6Md5OV')    
    render json: list_organization_memberships, status: :ok
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create

    email = params[:email]
    unless email
      render json: { error: "Email is required" }, status: :unprocessable_entity
      return
    end


  @user = User.find_or_initialize_by(email: email)

  @user.assign_attributes(
    org_slug: @clerk_session['org_slug'],
    clerk_user_id: @clerk_session['sub'],
    org_role: @clerk_session['org_role']
  )

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :role)
    end
end
