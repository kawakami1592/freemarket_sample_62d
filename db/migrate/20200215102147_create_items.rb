class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string     :name,         null: false
      t.text       :text
      t.references :user       
      t.references :category   
      t.references :condition 
      t.references :deliverycost
      t.references :pref
      t.references :delivery_days
      t.integer    :price,        null: false

      t.timestamps
    end
  end
end
