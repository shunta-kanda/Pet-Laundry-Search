class HomeController < ApplicationController
  def index
    @shops = Shop.where(published: true).where.not(latitude: nil, longitude: nil).includes(:area)
  end
end