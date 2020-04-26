class SparePartProfilesController < ApplicationController
  before_action -> {ensure_shop_admin params[:shop_id]}, only: [:create, :update]
  before_action -> {ensure_shop_admin get_shop_id_in_destroy}, only: [:destroy]

  def index
    @spare_part_profiles = SparePartProfile.where(spare_part_profile_search_params)
    render json: @spare_part_profiles
  end

  def create
    unless SparePartProfile.where(spare_part_profile_params).empty?
      render json: {message: 'Already exists'}, status: :ok
      return
    end
    @spare_part_profile = SparePartProfile.create!(spare_part_profile_params)
    render json: @spare_part_profile
  end

  def update
    @spare_part_profile = SparePartProfile.find params[:id]
    @spare_part_profile.update_attributes!(spare_part_profile_params)
    render json: @spare_part_profile
  end

  def destroy
    @spare_part_profile = SparePartProfile.find params[:id]
    if @spare_part_profile.destroy
      render status: :ok
    else
      render json: {error: 'Something went wrong. Could not delete spare part profile'}, status: :internal_server_error
    end
  end

  private
  def spare_part_profile_search_params
    params.permit(:shop_id, :spare_part_id, :vehicle_variant_id)
  end

  def spare_part_profile_params
    params.permit(:shop_id, :spare_part_id, :vehicle_variant_id, :price)
  end

  def get_shop_id_in_destroy
    @spare_part_profile = SparePartProfile.find params[:id]
    return @spare_part_profile.shop_id
  end
end
