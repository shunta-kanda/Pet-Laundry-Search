# frozen_string_literal: true

class ShopRequestsController < ApplicationController
  def new
    @shop_request = ShopRequest.new
  end

  def create
    @shop_request = ShopRequest.new(shop_request_params)

    if @shop_request.save
      # 送信成功時は、完了メッセージまたはサンクスページへリダイレクト
      redirect_to new_shop_request_path, notice: "情報提供リクエストを送信しました。ご協力ありがとうございます！"
    else
      # 送信失敗時は入力画面を再描画（エラーメッセージを表示）
      flash.now[:alert] = "入力内容にエラーがあります。修正してください。"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def shop_request_params
    # 許可するカラム名
    params.require(:shop_request).permit(:request_type, :shop_name, :address, :body)
  end
end