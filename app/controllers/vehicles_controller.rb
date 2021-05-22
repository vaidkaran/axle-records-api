class VehiclesController < ApplicationController
  before_action :ensure_customer

  def index
    render json: current_user.vehicles
  end

  def create
    vehicle = current_user.vehicles.create!(vehicle_params)
    render json: vehicle
  end

  def show
    vehicle = current_user.vehicles.find(params[:id])
    render json: vehicle
  end

  def update
    vehicle = current_user.vehicles.find(params[:id])
    vehicle.update_attributes!(vehicle_params)
    render json: vehicle
  end

  def destroy
    vehicle = current_user.vehicles.find(params[:id])
    vehicle.destroy!
    render json: {message: 'Deleted'}
  end


  private
  def vehicle_params
    vehicle_variant = VehicleVariant.find(params[:vehicle_variant_id])
    vehicle_model = vehicle_variant.vehicle_model
    vehicle_brand = vehicle_model.vehicle_brand
    return({
      name: params[:name],
      vehicle_brand_id: vehicle_brand.id,
      vehicle_model_id: vehicle_model.id,
      vehicle_variant_id: vehicle_variant.id
    })
  end
end
