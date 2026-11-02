# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'バリデーションのテスト' do
    context '有効なデータの場合' do
      it 'すべての属性が正しく設定されていれば有効であること' do
        admin = FactoryBot.build(:admin)
        expect(admin).to be_valid
      end
    end

    context 'presence（必須バリデーション）のテスト' do
      it 'emailが空の場合は無効であること' do
        admin = FactoryBot.build(:admin, email: nil)
        expect(admin).not_to be_valid
        expect(admin.errors[:email]).to include("can't be blank")
      end

      it 'passwordが空の場合は無効であること' do
        admin = FactoryBot.build(:admin, password: nil, password_confirmation: nil)
        expect(admin).not_to be_valid
      end
    end

    context 'uniqueness（一意性バリデーション）のテスト' do
      it 'emailがすでに存在する場合は無効であること' do
        FactoryBot.create(:admin, email: 'test@example.com')
        duplicate_admin = FactoryBot.build(:admin, email: 'test@example.com')
        expect(duplicate_admin).not_to be_valid
        expect(duplicate_admin.errors[:email]).to include('has already been taken')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
