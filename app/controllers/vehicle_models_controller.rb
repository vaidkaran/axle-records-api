class VehicleModelsController < ApplicationController
  before_action :ensure_site_admin, except: [:index]

  def index
    @vehicle_brand = VehicleBrand.find params[:vehicle_brand_id]
    @vehicle_models = @vehicle_brand.vehicle_models
    render json: @vehicle_models, status: :ok
  end

  def create
    @vehicle_brand = VehicleBrand.find params[:vehicle_brand_id]
    @vehicle_model = @vehicle_brand.vehicle_models.create! vehicle_model_params
    render json: @vehicle_model, status: :created
  end

  def update
    @vehicle_model = VehicleModel.find params[:id]
    if @vehicle_model.update_attributes(vehicle_model_params)
      render json: @vehicle_model, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update vehicle model'}, status: :internal_server_error
    end

  end


  private
  def vehicle_model_params
    params.permit(:name, :vehicle_category_id)
  end
end
