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
    params.permit(:name, :vehicle_variant_id)
  end
end
