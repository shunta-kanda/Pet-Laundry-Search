# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe ShopRequest, type: :model do
  describe 'バリデーションのテスト' do
    context '有効なデータの場合' do
      it 'すべての属性が正しく設定されていれば有効であること' do
        shop_request = FactoryBot.build(:shop_request)
        expect(shop_request).to be_valid
      end
    end

    context 'presence（必須バリデーション）のテスト' do
      it 'shop_nameが空の場合は無効であること' do
        shop_request = FactoryBot.build(:shop_request, shop_name: nil)
        expect(shop_request).not_to be_valid
        expect(shop_request.errors[:shop_name]).to include("can't be blank")
      end

      it 'addressが空の場合は無効であること' do
        shop_request = FactoryBot.build(:shop_request, address: nil)
        expect(shop_request).not_to be_valid
        expect(shop_request.errors[:address]).to include("can't be blank")
      end

      it 'request_typeが空の場合は無効であること' do
        shop_request = FactoryBot.build(:shop_request, request_type: nil)
        expect(shop_request).not_to be_valid
      end

      it 'statusが空の場合は無効であること' do
        shop_request = FactoryBot.build(:shop_request, status: nil)
        expect(shop_request).not_to be_valid
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
