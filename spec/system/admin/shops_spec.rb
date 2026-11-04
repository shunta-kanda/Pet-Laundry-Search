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
      # 1. 管理者ログイン
      visit admin_login_path
      fill_in 'メールアドレス', with: admin.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      # 2. 管理画面の店舗一覧ページへ移動
      visit admin_shops_path

      # 3. 登録されている店舗名が一覧に表示されていることを確認
      expect(page).to have_current_path(admin_shops_path)
      expect(page).to have_content('テストコインランドリー 博多店')
    end
  end
end
# rubocop:enable Metrics/BlockLength