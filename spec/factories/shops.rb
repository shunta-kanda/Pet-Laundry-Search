# frozen_string_literal: true

FactoryBot.define do
  factory :shop do
    association :area
    sequence(:name) { |n| "コインランドリー店舗 #{n}" }
    address { '東京都渋谷区代々木 1-1-1' }
    latitude { 35.6812 }
    longitude { 139.7671 }
    opening_hours { '24時間営業' }
    parking_available { true }
    google_maps_url { 'https://maps.google.com/?q=sample' }
    website_url { 'https://example.com' }
    published { true }
  end
end
