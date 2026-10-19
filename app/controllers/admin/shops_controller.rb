# frozen_string_literal: true

class Admin::ShopsController < Admin::BaseController
  before_action :set_shop, only: %i[edit update destroy]

  def index
    @shops = Shop.includes(:area, :machines).order(created_at: :desc)
  end

  def new
    @shop = Shop.new
    @shop.machines.build
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to admin_shops_path, notice: '店舗を登録しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @shop.machines.build if @shop.machines.empty?
  end

  def update
    if @shop.update(shop_params)
      redirect_to admin_shops_path, notice: '店舗情報を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shop.destroy
    redirect_to admin_shops_path, notice: '店舗を削除しました。'
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(
      :name, :area_id, :address, 
      :latitude,
      :longitude,
      :opening_hours,
      :parking_available, :google_maps_url, :website_url, :published,
      machines_attributes: machine_params
    )
  end

  def machine_params
    %i[
      id
      name
      quantity
      capacity
      price
      description
      _destroy
    ]
  end
end
