# frozen_string_literal: true

FactoryBot.define do
  factory :area do
    sequence(:name) { |n| "エリア#{n}" }
    sequence(:sort_order) { |n| n }
  end
end
