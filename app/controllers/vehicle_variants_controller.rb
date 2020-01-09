class VehicleVariantsController < ApplicationController
  before_action :ensure_site_admin, except: [:index]

  def index
    @vehicle_model = VehicleModel.find params[:vehicle_model_id]
    @vehicle_variants = @vehicle_model.vehicle_variants
    render json: @vehicle_variants, status: :ok
  end

  def create
    @vehicle_model = VehicleModel.find params[:vehicle_model_id]
    @vehicle_variant = @vehicle_model.vehicle_variants.create! vehicle_variant_params
    render json: @vehicle_variant, status: :created
  end

  def update
    @vehicle_variant = VehicleVariant.find params[:id]
    if @vehicle_variant.update_attributes(vehicle_variant_params)
      render json: @vehicle_variant, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update vehicle variant'}, status: :internal_server_error
    end

  end


  private
  def vehicle_variant_params
    params.permit(:name)
  end
end
