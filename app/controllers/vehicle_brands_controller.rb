class VehicleBrandsController < ApplicationController
  before_action :ensure_site_admin, except: [:index]

  def index
    @vehicle_brands = VehicleBrand.all
    render json: @vehicle_brands, status: :ok
  end

  def create
    @vehicle_brand = VehicleBrand.create! vehicle_brand_params
    render json: @vehicle_brand, status: :created
  end

  def update
    @vehicle_brand = VehicleBrand.find params[:id]
    if @vehicle_brand.update_attributes(vehicle_brand_params)
      render json: @vehicle_brand, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update vehicle brand'}, status: :internal_server_error
    end

  end


  private
  def vehicle_brand_params
    params.permit(:name)
  end

end
