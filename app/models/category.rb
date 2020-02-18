class Category < ApplicationRecord
  has_many :items
  has_ancestry
end


def change
  add_column :categories, :ancestry, :string
  add_index :categories, :ancestry
end