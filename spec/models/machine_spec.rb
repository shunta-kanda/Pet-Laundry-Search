# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'バリデーションのテスト' do
    context '有効なデータの場合' do
      it 'すべての属性が正しく設定されていれば有効であること' do
        machine = FactoryBot.build(:machine)
        expect(machine).to be_valid
      end
    end

    context 'presence（必須バリデーション）のテスト' do
      it 'nameが空の場合は無効であること' do
        machine = FactoryBot.build(:machine, name: nil)
        expect(machine).not_to be_valid
        expect(machine.errors[:name]).to include("can't be blank")
      end

      it 'shop（関連付け）が空の場合は無効であること' do
        machine = FactoryBot.build(:machine, shop: nil)
        expect(machine).not_to be_valid
        expect(machine.errors[:shop]).to include('must exist')
      end

      it 'quantityが空の場合は無効であること' do
        machine = FactoryBot.build(:machine, quantity: nil)
        expect(machine).not_to be_valid
        expect(machine.errors[:quantity]).to include("can't be blank")
      end
    end
  end
end
