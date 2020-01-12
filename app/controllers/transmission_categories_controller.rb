class TransmissionCategoriesController < ApplicationController
  before_action :ensure_site_admin, except: [:index]

  def index
    @transmission_categories = TransmissionCategory.all
    render json: @transmission_categories, status: :ok
  end

  def create
    @transmission_category = TransmissionCategory.create! transmission_category_params
    render json: @transmission_category, status: :created
  end

  def update
    @transmission_category = TransmissionCategory.find params[:id]
    if @transmission_category.update_attributes(transmission_category_params)
      render json: @transmission_category, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update transmission category'}, status: :internal_server_error
    end

  end


  private
  def transmission_category_params
    params.permit(:name)
  end

end
