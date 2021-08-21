class JobsController < ApplicationController
  before_action :ensure_either_vendor_or_site_admin

  def index
    @jobs = Job.all
    render json: @jobs, status: :ok
  end

  def show
    @job = Job.find params[:id]
    render json: @job, status: :ok
  end

  def create
    if Job.find_by(name: job_params[:name])
      render json: {message: 'Already exists'}, status: :conflict
      return
    end
    create_job_params = job_params
    if current_user.is_vendor
      create_job_params[:user_defined] = true
    end
    @job = Job.create! create_job_params
    render json: @job, status: :created
  end

  def update
    # vendor should not be able to update any record with user_defined false
    @job = Job.find params[:id]
    if @job.update_attributes(job_params)
      render json: @job, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update job'}, status: :internal_server_error
    end
  end


  private
  def job_params
    params.permit(:name, :description, :user_defined)
  end
end
