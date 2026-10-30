# frozen_string_literal: true

admin_email = ENV['ADMIN_EMAIL'] || 'admin@example.com'
admin_password = ENV['ADMIN_PASSWORD'] || 'default_password'

Admin.find_or_create_by!(email: admin_email) do |admin|
  admin.password = admin_password
  admin.password_confirmation = admin_password
end

Rails.logger.debug "✅ 管理者データを作成しました: #{admin_email}"

# 2. エリアデータの作成（福岡県の4地域）
areas_data = [
  { name: '北九州', sort_order: 1 },
  { name: '福岡', sort_order: 2 },
  { name: '筑後', sort_order: 3 },
  { name: '筑豊', sort_order: 4 }
]

areas_data.each do |data|
  Area.find_or_create_by!(name: data[:name]) do |area|
    area.sort_order = data[:sort_order]
  end
end
puts '✅ エリアデータを作成しました。'

# 3. エリアの取得（ここでは「福岡」地域にサンプル店舗を紐付けます）
fukuoka_area = Area.find_by!(name: '福岡')

# 4. サンプル店舗データの作成
shop = Shop.find_or_create_by!(name: 'ペットコインランドリー天神') do |s|
  s.area = fukuoka_area
  s.address = '福岡県福岡市中央区天神1-1-1'
  s.latitude = 33.5902
  s.longitude = 130.4017
  s.opening_hours = '24時間営業'
  s.parking_available = true
  s.google_maps_url = 'https://maps.google.com/?q=33.5902,130.4017'
  s.website_url = 'https://example.com/tenjin-pet-laundry'
  s.published = true
end
puts '✅ 店舗データを作成しました。'

# 5. サンプル機器データの作成（確実に保存された shop を渡す）
Machine.find_or_create_by!(name: '大型ペット用洗濯乾燥機', shop: shop) do |m|
  m.quantity = 2
  m.capacity = '15kg'
  m.price = '1,000円 / 60分'
  m.description = '毛布や大型のペットベッドもまとめて洗える大型機です。'
end

Machine.find_or_create_by!(name: '小型ペット用洗濯機', shop: shop) do |m|
  m.quantity = 3
  m.capacity = '7kg'
  m.price = '600円 / 40分'
  m.description = '普段使いのお洋服やタオルに最適です。'
end
puts '✅ 機器データを作成しました。'

# 6. サンプル店舗リクエストデータの作成
ShopRequest.find_or_create_by!(shop_name: 'ドッグ洗たく博多店') do |req|
  req.request_type = 0 # 0: 新規掲載
  req.address = '福岡県福岡市博多区博多駅前2-1-1'
  req.body = '新規オープン予定のペット専用コインランドリーです。掲載をお願いします。'
  req.status = 0 # 0: 未対応
  req.admin_note = 'オープン日を確認して対応する'
end
puts '✅ 店舗リクエストデータを作成しました。'