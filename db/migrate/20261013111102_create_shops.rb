class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.references :area, null: false, foreign_key: true, comment: "エリアID"
      t.string :name, null: false, comment: "店舗名"
      t.string :address, null: false, comment: "住所"
      t.float :latitude, comment: "緯度(geocoder)"
      t.float :longitude, comment: "経度(geocoder)"
      t.string :opening_hours, comment: "営業時間"
      t.boolean :parking_available, default: false, null: false, comment: "駐車場有無"
      t.string :google_maps_url, comment: "GoogleマップURL"
      t.string :website_url, comment: "公式URL"
      t.boolean :published, default: false, null: false, comment: "掲載フラグ"

      t.timestamps
    end
  end
end