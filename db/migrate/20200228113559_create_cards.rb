class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string  :exp_month
      t.string  :exp_year
      t.string  :brand
      t.string  :last4
      t.timestamps
    end
  end
end
