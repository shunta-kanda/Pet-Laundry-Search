# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Area, type: :model do
  describe 'バリデーションのテスト' do
    context '有効なデータの場合' do
      it 'すべての属性が正しく設定されていれば有効であること' do
        area = FactoryBot.build(:area)
        expect(area).to be_valid
      end
    end

    context 'presence（必須バリデーション）のテスト' do
      it 'nameが空の場合は無効であること' do
        area = FactoryBot.build(:area, name: nil)
        expect(area).not_to be_valid
        expect(area.errors[:name]).to include("can't be blank")
      end
    end

    context 'uniqueness（一意性バリデーション）のテスト' do
      it 'nameがすでに存在する場合は無効であること' do
        FactoryBot.create(:area, name: '東京都')
        duplicate_area = FactoryBot.build(:area, name: '東京都')
        expect(duplicate_area).not_to be_valid
        expect(duplicate_area.errors[:name]).to include('has already been taken')
      end
    end
  end
end
