class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string     :name, null: false
      t.text       :text, null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false
      t.references :condition, null: false
      t.references :deliverycost, null: false
      t.references :pref, null: false
      t.references :delivery_days, null: false
      t.integer    :price, null: false
      t.references :boughtflg, null: false

      t.timestamps
    end
  end
end