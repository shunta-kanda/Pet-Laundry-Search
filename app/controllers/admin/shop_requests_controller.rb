# frozen_string_literal: true

class Admin::ShopRequestsController < Admin::BaseController
  def index
    @shop_requests = ShopRequest.order(created_at: :desc)
    
    # ステータスによるフィルタリング（パラメータが存在する場合）
    if params[:status].present?
      @shop_requests = @shop_requests.where(status: params[:status])
    end
  end

  def show
    @shop_request = ShopRequest.find(params[:id])
  end
end