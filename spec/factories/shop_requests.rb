FactoryBot.define do
  factory :shop_request do
    admin { nil } # 初期状態は未対応のためNULL許可
    request_type { 0 } # 0:新規掲載
    shop_name { "新規コインランドリー希望" }
    address { "東京都新宿区西新宿 2-8-1" }
    body { "近所に新しい店舗ができたので掲載をお願いします。" }
    status { 0 } # 0:未対応
    admin_note { nil }
  end
end