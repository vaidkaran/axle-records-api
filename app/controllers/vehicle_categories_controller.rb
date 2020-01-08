class VehicleCategoriesController < ApplicationController
  before_action :ensure_site_admin, except: [:index]

  def index
    @vehicle_categories = VehicleCategory.all
    render json: @vehicle_categories, status: :ok
  end

  def create
    @vehicle_category = VehicleCategory.create! vehicle_category_params
    render json: @vehicle_category, status: :created
  end

  def update
    @vehicle_category = VehicleCategory.find params[:id]
    if @vehicle_category.update_attributes(vehicle_category_params)
      render json: @vehicle_category, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update vehicle category'}, status: :internal_server_error
    end

  end


  private
  def vehicle_category_params
    params.permit(:name)
  end

end
