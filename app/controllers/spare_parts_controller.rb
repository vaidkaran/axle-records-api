class SparePartsController < ApplicationController
  before_action :ensure_site_admin, except: [:index, :show]

  def index
    @spare_parts = SparePart.all
    render json: @spare_parts, status: :ok
  end

  def show
    @spare_part = SparePart.find params[:id]
    render json: @spare_part, status: :ok
  end

  def create
    @spare_part = SparePart.create! spare_part_params
    render json: @spare_part, status: :created
  end

  def update
    @spare_part = SparePart.find params[:id]
    if @spare_part.update_attributes(spare_part_params)
      render json: @spare_part, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update spare part'}, status: :internal_server_error
    end
  end


  private
  def spare_part_params
    params.permit(:name, :description)
  end
end
