# frozen_string_literal: true

FactoryBot.define do
  factory :area do
    sequence(:name) { |n| "エリア#{n}" }
    sort_order { 1 }
  end
end
