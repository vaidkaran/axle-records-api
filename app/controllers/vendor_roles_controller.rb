class VendorRolesController < ApplicationController
  before_action :ensure_site_admin, except: [:index]

  def index
    @vendor_roles = VendorRole.all
    render json: @vendor_roles, status: :ok
  end

  def create
    @vendor_role = VendorRole.create! vendor_role_params
    render json: @vendor_role, status: :created
  end

  def update
    @vendor_role = VendorRole.find params[:id]
    if @vendor_role.update_attributes(vendor_role_params)
      render json: @vendor_role, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update vendor role'}, status: :internal_server_error
    end
  end

  private
  def vendor_role_params
    params.permit(:name)
  end

end
