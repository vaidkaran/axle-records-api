class JobProfilesController < ApplicationController
  before_action -> {ensure_shop_admin params[:shop_id]}, only: [:create, :destroy, :update]

  def index
    @job_profiles = JobProfile.where(job_profile_search_params)
    render json: @job_profiles
  end

  def create
    unless JobProfile.where(job_profile_params).empty?
      render json: {message: 'Already exists'}, status: :ok
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
    params.permit(:shop_id, :job_id, :vehicle_variant_id)
  end

  def job_profile_params
    params.permit(:shop_id, :job_id, :vehicle_variant_id, :price,
                  :estimatedTimeInMins, :estimatedTimeInHrs)
  end
end
