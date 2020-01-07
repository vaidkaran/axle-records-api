class VehicleCategoriesController < ApplicationController
  before_action :require_site_admin, except: [:index]

  def index
    @vehicle_categories = VehicleCategory.all
    render json: @vehicle_categories, status: :ok
  end

  # TODO: create endpoint with require_site_admin
  # Also keep require_site_admin as a helper method
  def create
    @vehicle_category = VehicleCategory.create! vehicle_category_params
    render json: @vehicle_category, status: :created
  end


  private
  def vehicle_category_params
    params.permit(:name)
  end

  def require_site_admin
    unless(current_user.site_role.name === 'admin')
      render json: {error: 'You need to be a site admin for performing this operation'}, status: :forbidden
    end
  end
end
