# frozen_string_literal: true

class Admin::ShopRequestsController < Admin::BaseController
  def index
    @shop_requests = ShopRequest.order(created_at: :desc)

    # ステータスによるフィルタリング（パラメータが存在する場合）
    return unless params[:status].present?

    @shop_requests = @shop_requests.where(status: params[:status])
  end

  def show
    @shop_request = ShopRequest.find(params[:id])
  end

  def update
    @shop_request = ShopRequest.find(params[:id])
    if @shop_request.update(shop_request_params)
      redirect_to admin_shop_request_path(@shop_request), notice: 'リクエストのステータスを更新しました。'
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def shop_request_params
    params.require(:shop_request).permit(:status)
  end
end
