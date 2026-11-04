# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '一般ユーザー向け店舗リクエスト送信フロー', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:area) { create(:area, name: '福岡エリア') }
  let!(:shop) { create(:shop, area: area, name: 'テストコインランドリー', address: '福岡県福岡市中央区天神1-1-1', published: true) }

  describe 'リクエストの新規作成フロー' do
    it '一般ユーザーが店舗情報修正のリクエストを正常に送信できること' do
      visit new_shop_request_path

      # フォームに必要事項を入力する
      select '情報修正', from: 'リクエスト種別'
      fill_in '店舗名', with: shop.name
      fill_in '住所', with: shop.address
      fill_in '詳細内容・修正内容', with: '営業時間の変更をお願いします。'

      click_button '送信する'

      expect(page).to have_current_path(new_shop_request_path)
      expect(page).to have_content('情報提供リクエストを送信しました')
      expect(ShopRequest.last).to have_attributes(
        shop_name: shop.name,
        address: shop.address,
        body: '営業時間の変更をお願いします。'
      )
    end
  end
end
