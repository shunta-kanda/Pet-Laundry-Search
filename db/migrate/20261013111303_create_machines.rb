class CreateMachines < ActiveRecord::Migration[7.0]
  def change
    create_table :machines do |t|
      t.references :shop, null: false, foreign_key: true, comment: "店舗ID"
      t.string :name, null: false, comment: "機器名"
      t.integer :quantity, default: 1, null: false, comment: "台数"
      t.string :capacity, comment: "容量"
      t.string :price, comment: "料金"
      t.text :description, comment: "補足説明"

      t.timestamps
    end
  end
end