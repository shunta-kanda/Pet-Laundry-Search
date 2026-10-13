class CreateShopRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :shop_requests do |t|
      t.references :admin, foreign_key: true, comment: "対応管理者ID (NULL許可)"
      t.integer :request_type, default: 0, null: false, comment: "種別(0:新規掲載, 1:情報修正, 2:閉業報告)"
      t.string :shop_name, null: false, comment: "対象店舗名"
      t.string :address, comment: "住所(任意)"
      t.text :body, null: false, comment: "リクエスト詳細"
      t.integer :status, default: 0, null: false, comment: "ステータス(0:未対応, 1:完了, 2:不採用)"
      t.text :admin_note, comment: "管理者用メモ"

      t.timestamps
    end
  end
end