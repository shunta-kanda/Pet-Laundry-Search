# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shops', type: :request do
  describe 'GET /show' do
    let(:area) { Area.create!(name: 'テストエリア') }
    let(:shop) { Shop.create!(name: 'テスト店舗', address: '福岡県福岡市', published: true, area: area) }

    it 'returns http success' do
      get shop_path(shop)
      expect(response).to have_http_status(:success)
    end
  end
end