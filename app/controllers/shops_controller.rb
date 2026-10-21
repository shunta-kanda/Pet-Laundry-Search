# frozen_string_literal: true

class ShopsController < ApplicationController
  def show
    @shop = Shop.where(published: true).find(params[:id])
  end
end