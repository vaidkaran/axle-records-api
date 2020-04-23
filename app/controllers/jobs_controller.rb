class JobsController < ApplicationController
  before_action :ensure_site_admin, except: [:index, :show]

  def index
    @jobs = Job.all
    render json: @jobs, status: :ok
  end

  def show
    @job = Job.find params[:id]
    render json: @job, status: :ok
  end

  def create
    @job = Job.create! job_params
    render json: @job, status: :created
  end

  def update
    @job = Job.find params[:id]
    if @job.update_attributes(job_params)
      render json: @job, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update job'}, status: :internal_server_error
    end
  end


  private
  def job_params
    params.permit(:name, :description)
  end
end
