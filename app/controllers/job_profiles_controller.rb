class JobProfilesController < ApplicationController
  before_action -> {ensure_shop_admin params[:shop_id]}, only: [:create, :update]
  before_action -> {ensure_shop_admin get_shop_id_in_destroy}, only: [:destroy]

  def index
    @job_profiles = JobProfile.where(job_profile_search_params)
    # render json: @job_profiles
    render json: @job_profiles.to_json({only: [:id, :name, :job_id, :shop_id],
      include: [{job: {only: [:id, :name, :description, :user_defined]}}]})
  end

  def create
    unless JobProfile.where({shop_id: params[:shop_id], job_id: params[:job_id]}).empty?
      render json: {message: 'Already exists'}, status: :conflict
      return
    end
    @job_profile = JobProfile.create!(job_profile_params)
    render json: @job_profile
  end

  def update
    @job_profile = JobProfile.find params[:id]
    @job_profile.update_attributes!(job_profile_params)
    render json: @job_profile
  end

  def destroy
    @job_profile = JobProfile.find params[:id]
    if @job_profile.destroy
      render status: :ok
    else
      render json: {error: 'Something went wrong. Could not delete job profile'}, status: :internal_server_error
    end
  end

  private
  def job_profile_search_params
    # removed :vehicle_variant_id since it's not a part of job_profiles in mvp
    params.permit(:shop_id, :job_id)
  end

  # removed :vehicle_variant_id since it's not a part of job_profiles in mvp
  # also removed :estimatedTimeInMins, :estimatedTimeInHrs in mvp
  def job_profile_params
    params.permit(:shop_id, :job_id, :price)
  end

  def get_shop_id_in_destroy
    @job_profile = JobProfile.find params[:id]
    return @job_profile.shop_id
  end
end
