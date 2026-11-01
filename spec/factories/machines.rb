# frozen_string_literal: true

FactoryBot.define do
  factory :machine do
    association :shop
    name { '洗濯乾燥機' }
    quantity { 3 }
    capacity { '10kg' }
    price { '800円' }
    description { '洗剤自動投入機能付き' }
  end
end
