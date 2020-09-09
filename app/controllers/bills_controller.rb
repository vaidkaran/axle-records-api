class BillsController < ApplicationController
  before_action :ensure_vendor
  before_action -> {ensure_shop_member_from_jobsheet params[:jobsheet_id]}

  #find out how to include tax in the json response
  # and then add it in index and generate methods
  #
  def index
    jobsheet = Jobsheet.find(params[:jobsheet_id])
    render json: jobsheet.bill
  end

  def generate
    item_total = 0
    jobsheet = Jobsheet.find(params[:jobsheet_id])
    if jobsheet.bill
      render json: { message: 'Bill already exists for this jobsheet' }
      return
    end

    jobsheet.job_trackers.each do |job_tracker|
      item_total += job_tracker.job_profile.price
    end
    bill = jobsheet.create_bill!({item_total: total_price})
    tax_percent = jobsheet.shop.tax_percent
    grand_total = item_total * (100 + tax_percent)
    render json: bill
  end

  def destroy
    jobsheet = Jobsheet.find(params[:jobsheet_id])
    if jobsheet.bill
      jobsheet.bill.destroy!
      render json: {message: 'Deleted'}, status: :ok
    else
      render json: {message: 'No bill exists for the jobsheet'}, status: :ok
    end
  end
end
