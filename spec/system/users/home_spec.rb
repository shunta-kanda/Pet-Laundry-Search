# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '一般ユーザー向けトップページ・検索フロー', type: :system do
  before do
    driven_by(:rack_test)
    Shop.destroy_all
    Area.destroy_all
  end

  let!(:area_fukuoka) { create(:area, name: '福岡エリア') }
  let!(:area_yamaguchi) { create(:area, name: '山口エリア') }

  let!(:shop_fukuoka) { create(:shop, name: '福岡コインランドリー', area: area_fukuoka, address: '福岡市中央区1-1', published: true) }
  let!(:shop_yamaguchi) do
    create(:shop, name: '山口コインランドリー', area: area_yamaguchi, address: '山口市中央1-1', published: true)
  end

  describe 'トップページの表示と店舗一覧' do
    it '公開されているすべての店舗が一覧表示されること' do
      visit root_path

      expect(page).to have_content('ペットコインランドリー検索')
      expect(page).to have_content('福岡コインランドリー')
      expect(page).to have_content('山口コインランドリー')
      expect(page).to have_content('該当件数: 2 件')
    end
  end

  describe 'エリア絞り込み機能' do
    it '選択したエリアの店舗のみに絞り込まれること' do
      visit root_path(area_id: area_fukuoka.id)

      expect(page).to have_content('福岡コインランドリー')
      expect(page).not_to have_content('山口コインランドリー')
      expect(page).to have_content('該当件数: 1 件')
    end
  end

  describe '店舗詳細画面への遷移' do
    it '店舗名をクリックして詳細ページへ移動できること' do
      visit root_path

      click_link '福岡コインランドリー'

      expect(page).to have_current_path(shop_path(shop_fukuoka))
      expect(page).to have_content('福岡コインランドリー')
      expect(page).to have_content('福岡市中央区1-1')
    end
  end
end
# rubocop:enable Metrics/BlockLength
