# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @shops = Shop.where(published: true).where.not(latitude: nil, longitude: nil).includes(:area)

    @shops = @shops.where(area_id: params[:area_id]) if params[:area_id].present?

    @areas = Area.order(:sort_order)
  end

  def terms; end
end
