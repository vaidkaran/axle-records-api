class FuelCategoriesController < ApplicationController
  before_action :ensure_site_admin, except: [:index]

  def index
    @fuel_categories = FuelCategory.all
    render json: @fuel_categories, status: :ok
  end

  def create
    @fuel_category = FuelCategory.create! fuel_category_params
    render json: @fuel_category, status: :created
  end

  def update
    @fuel_category = FuelCategory.find params[:id]
    if @fuel_category.update_attributes(fuel_category_params)
      render json: @fuel_category, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update fuel category'}, status: :internal_server_error
    end

  end


  private
  def fuel_category_params
    params.permit(:name)
  end

end
