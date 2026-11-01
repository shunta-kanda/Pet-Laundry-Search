# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe 'バリデーションのテスト' do
    context '有効なデータの場合' do
      it 'すべての属性が正しく設定されていれば有効であること' do
        shop = FactoryBot.build(:shop)
        expect(shop).to be_valid
      end
    end

    context 'presence（必須バリデーション）のテスト' do
      it 'nameが空の場合は無効であること' do
        shop = FactoryBot.build(:shop, name: nil)
        expect(shop).not_to be_valid
        expect(shop.errors[:name]).to include('を入力してください')
      end

      it 'area（関連付け）が空の場合は無効であること' do
        shop = FactoryBot.build(:shop, area: nil)
        expect(shop).not_to be_valid
        expect(shop.errors[:area]).to include('を入力してください')
      end
    end
  end
end