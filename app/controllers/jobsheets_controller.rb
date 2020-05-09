class JobsheetsController < ApplicationController
  before_action :ensure_vendor
  before_action -> {ensure_shop_member params[:shop_id]}

  def index
    @jobsheets = Shop.find(params[:shop_id]).jobsheets
    render json: @jobsheets, status: :ok
  end

  def show
    @jobsheet = Jobsheet.find(params[:id])
    render json: @jobsheet, include: {jobsheet_state_trackers: {include: :jobsheet_state}}, status: :ok
  end

  def create
    Jobsheet.transaction do
      @jobsheet = Jobsheet.create!(jobsheet_params)
      @jobsheet.jobsheet_state_trackers.create!(
        jobsheet_state_id: JobsheetState.find_by(name: :open).id
      )
    end
    render json: @jobsheet.jobsheet_state_trackers, status: :created
  end

  def set_state
    state_name = params[:state]
    @jobsheet = Jobsheet.find(params[:id])
    # check current state
    if @jobsheet.jobsheet_state_trackers.last.jobsheet_state.name == state_name
      render json: { message: "State is already #{state_name}" } and return
    end
    @jobsheet.jobsheet_state_trackers.create!(
      jobsheet_state_id: JobsheetState.find_by(name: state_name).id
    )
    render json: @jobsheet, include: {jobsheet_state_trackers: {include: :jobsheet_state}}, status: :ok
  end

  def add_job
    @jobsheet = Jobsheet.find(params[:id])
    @jobsheet.job_trackers.create!(job_profile_id: params[:job_profile_id])
    render json: @jobsheet, include: {job_trackers: {include: :job_profile}}, status: :ok
  end

  private
  def jobsheet_params
    params.permit(:shop_id, :vehicle_id)
  end
end
