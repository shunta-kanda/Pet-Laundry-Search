class HomeController < ApplicationController
  def index
    @shops = Shop.where(published: true).where.not(latitude: nil, longitude: nil).includes(:area)

    if params[:area_id].present?
      @shops = @shops.where(area_id: params[:area_id])
    end

    @areas = Area.order(:sort_order) 
  end
end