class EmployersController < ApplicationController

  def index
    organization_memberships = Clerk::SDK.new.organization_memberships
    list_organization_memberships = organization_memberships.list_organization_memberships('org_2vLMkZCAXOv6VCUPj24tb6Md5OV', query_params: { role: 'org:carbon_credits_employer'})    
    render json: list_organization_memberships, status: :ok
  end
  

  def create

    organization_invitations = Clerk::SDK.new.organization_invitations

    create_invitation = organization_invitations.create_organization_invitation('org_2vLMkZCAXOv6VCUPj24tb6Md5OV', create_organization_invitation_request: {role: 'org:carbon_credits_employer',email_address: params[:email_address]})

    # puts "User created: #{organization_invitations}"
    
    render json: { message: "Employer invitation sent successfully", invitation: create_invitation }, status: :created
  end

end
