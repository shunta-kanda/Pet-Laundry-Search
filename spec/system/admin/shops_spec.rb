# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe '管理者向け店舗管理フロー', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin) { create(:admin, email: 'admin@example.com', password: 'password', password_confirmation: 'password') }
  let!(:shop) { create(:shop, name: 'テストコインランドリー 博多店') }

  describe '店舗一覧・管理フロー' do
    it '管理者がログインして店舗一覧を確認できること' do
      visit admin_login_path
      fill_in 'メールアドレス', with: admin.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      visit admin_shops_path
      expect(page).to have_current_path(admin_shops_path)
      expect(page).to have_content('テストコインランドリー 博多店')
    end
  end

  describe '店舗の新規作成機能' do
    let!(:area) { create(:area, name: "テストエリア_#{SecureRandom.hex(4)}") }

    it '管理者が新しい店舗を登録できること' do
      visit admin_login_path
      fill_in 'メールアドレス', with: admin.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      visit new_admin_shop_path

      fill_in '店舗名', with: 'テストコインランドリー 天神店'
      select area.name, from: 'エリア'
      fill_in '住所', with: '福岡市中央区天神1-1-1'
      
      within('#machines-container') do
        first("input[name*='[name]']").set('大型洗濯乾燥機')
      end

      click_button '登録する'

      expect(page).to have_current_path(admin_shops_path)
      expect(page).to have_content('テストコインランドリー 天神店')
    end
  end

  describe '店舗の編集機能' do
    let!(:area) { create(:area, name: 'エリアA') }
    # :with_machine を外し、通常の create でショップを作成
    let!(:target_shop) { create(:shop, name: '編集前コインランドリー', area: area, address: '福岡市中央区天神1丁目') }
    # 紐づく機器を別で作成
    let!(:machine) { create(:machine, shop: target_shop, name: '標準洗濯機') }

    it '管理者が既存の店舗情報を編集できること' do
      visit admin_login_path
      fill_in 'メールアドレス', with: admin.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      visit edit_admin_shop_path(target_shop)

      fill_in '店舗名', with: '編集後コインランドリー 博多店'
      fill_in '住所', with: '福岡市博多区博多駅前2丁目'

      click_button '更新する'

      expect(page).to have_content('編集後コインランドリー 博多店')
      expect(page).not_to have_content('編集前コインランドリー')
    end
  end

  describe '店舗の削除機能' do
    let!(:area) { create(:area, name: 'エリアA') }
    let!(:target_shop) { create(:shop, name: '削除対象コインランドリー', area: area) }
    let!(:machine) { create(:machine, shop: target_shop, name: '標準洗濯機') }

    it '管理者が既存の店舗を削除できること' do
      visit admin_login_path
      fill_in 'メールアドレス', with: admin.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      # 一覧画面へ移動
      visit admin_shops_path

      # 「削除対象コインランドリー」が表示されている行（または周辺）にある削除ボタン／リンクをクリック
      within('tr', text: '削除対象コインランドリー') do
        click_on '削除'
      end

      # 削除成功の検証
      expect(page).to have_current_path(admin_shops_path)
      expect(page).not_to have_content('削除対象コインランドリー')
    end
  end
end
# rubocop:enable Metrics/BlockLength