class ShopsController < ApplicationController
  before_action :ensure_site_admin, only: [:index]
  before_action :ensure_vendor, except: [:index]
  before_action -> {ensure_shop_admin params[:id]},
    only: [:update, :destroy, :add_vendor, :update_vendor_role, :remove_vendor]
  before_action -> {ensure_shop_member params[:id]}, only: [:show, :vendors]

  def index
    @shops = Shop.all
    render json: @shops, status: :ok
  end

  def create
    @shop = Shop.create! shop_params
    @vendor_shop_role = VendorShopRole.create!(shop_id: @shop.id,
                                               user_id: current_user.id,
                                               vendor_role_id: VendorRole.find_by(name: :admin).id)
    render json: @shop, status: :created
  end

  def show
    @shop = Shop.find params[:id]
    render json: @shop, status: :ok
  end

  def update
    @shop = Shop.find params[:id]
    if @shop.update_attributes(shop_params)
      render json: @shop, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update shop'}, status: :internal_server_error
    end
  end

  def destroy
    @shop = Shop.find params[:id]
    if @shop.destroy
      render status: :ok
    else
      render json: {error: 'Something went wrong. Could not delete shop'}, status: :internal_server_error
    end
  end

  def add_vendor
    shop_id = params[:id]
    user = User.find(params[:user_id])
    unless(user.site_roles.include? SiteRole.find_by(name: :vendor))
      render json: {error: 'Only vendors can be added to a shop'}, status: :ok
      return
    end
    already_added = user.vendor_shop_roles.where(shop_id: shop_id).exists?
    if already_added
      render json: {error: 'User is already added to the shop'}, status: :ok
      return
    end

    @vendor_shop_role = VendorShopRole.create!(shop_id: shop_id,
                                               user_id: user.id,
                                               vendor_role_id: params[:vendor_role_id])
    render json: {message: 'Vendor added'}, status: :ok
  end

  def vendors
    vendors = VendorShopRole.where(shop_id: params[:id])
    render json: vendors, status: :ok
  end

  def update_vendor_role
    @vendor = VendorShopRole.where(shop_id: params[:id])
                           .where(user_id: params[:user_id])
                           .first
    if @vendor.update_attributes(vendor_role_id: params[:vendor_role_id])
      render json: @vendor, status: :ok
    else
      render json: {error: 'Something went wrong. Could not update vendor role in shop'}, status: :internal_server_error
    end
  end

  def remove_vendor
    @vendor = VendorShopRole.where(shop_id: params[:id])
                            .where(user_id: params[:user_id])
                            .first
    if @vendor.destroy
      render status: :ok
    else
      render json: {error: 'Something went wrong. Could not remove vendor'}, status: :internal_server_error
    end

  end

  private
  def shop_params
    params.permit(:name, :tax_percent, :address, :city, :state, :pin, :country)
  end
end
