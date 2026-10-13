class CreateAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :areas do |t|
      t.string :name, null: false, comment: "エリア名"
      t.integer :sort_order, default: 0, null: false, comment: "表示順"

      t.timestamps
    end
    add_index :areas, :name, unique: true
  end
end