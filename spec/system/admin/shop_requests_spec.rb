# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '管理者向け店舗リクエスト管理フロー', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:admin) { create(:admin, email: 'admin@example.com', password: 'password', password_confirmation: 'password') }
  let!(:shop_request) { create(:shop_request, shop_name: 'テストコインランドリー', status: 0) } # 0: 未対応

  describe 'リクエストの対応・判定フロー' do
    it '管理者がログインして店舗リクエストの一覧確認およびステータス更新ができること' do
      # 1. 管理者ログイン画面にアクセスしてログインする
      visit admin_login_path

      fill_in 'メールアドレス', with: admin.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      # 2. ログイン後、管理画面のトップ（ダッシュボード等）に遷移したことを確認
      expect(page).to have_current_path(admin_root_path) # または '/admin'

      # 3. 店舗リクエスト一覧ページへ移動（※もしダッシュボード等に一覧へのリンクがあればそれをクリック、なければ visit admin_shop_requests_path）
      visit admin_shop_requests_path # またはリンクをクリックする操作に置き換え可能

      # 4. 一覧ページでリクエストが表示されていることを確認
      expect(page).to have_content('テストコインランドリー')
      expect(page).to have_content('未対応')

      # 5. 該当リクエストの「詳細」リンクをクリックして詳細画面へ移動
      click_link '詳細'

      # 6. 詳細画面でステータスを「完了」(1)に変更して更新する
      select '完了', from: 'shop_request[status]'
      click_button '更新'

      # 7. 更新成功のメッセージと、DBのデータが正常に更新されていることを検証
      expect(page).to have_content('リクエストのステータスを更新しました')
      expect(shop_request.reload.status).to eq('approved')
    end
  end

  describe '管理者認証フロー（ログイン失敗・ログアウト）' do
    it '誤った認証情報ではログインできずエラーメッセージが表示されること' do
      visit admin_login_path

      fill_in 'メールアドレス', with: 'wrong@example.com'
      fill_in 'パスワード', with: 'wrongpassword'
      click_button 'ログイン'

      expect(page).to have_content('メールアドレスまたはパスワードが間違っています。')
      expect(current_path).to eq(admin_login_path)
    end

    it 'ログイン状態から正常にログアウトできること' do
      visit admin_login_path
      fill_in 'メールアドレス', with: admin.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      expect(page).to have_current_path(admin_root_path)

      click_button 'ログアウト'

      expect(page).to have_content('ログアウトしました。')
      expect(current_path).to eq(admin_login_path)
    end
  end

  describe 'リクエストのステータス更新失敗フロー' do
    it '更新に失敗した場合、詳細画面が再描画されること' do
      # 1. 管理者としてログインして詳細画面へ移動
      visit admin_login_path
      fill_in 'メールアドレス', with: admin.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      visit admin_shop_request_path(shop_request)

      # 2. updateが失敗する状況をシミュレートするため、インスタンスのupdateをfalseにスタブ化する
      allow_any_instance_of(ShopRequest).to receive(:update).and_return(false)

      # 3. 更新を試みる
      select '完了', from: 'shop_request[status]'
      click_button '更新'

      # 4. render :show が実行され、詳細画面にとどまることを検証
      expect(current_path).to eq(admin_shop_request_path(shop_request))
    end
  end
end
# rubocop:enable Metrics/BlockLength
