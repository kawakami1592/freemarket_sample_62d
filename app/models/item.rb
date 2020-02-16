class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :pref
  belongs_to_active_hash :deliverycost
  belongs_to_active_hash :delivery_days
  belongs_to_active_hash :birthyear
  belongs_to_active_hash :birthmonth
  belongs_to_active_hash :birthday
# 上記active_hashのアソシエーション

  has_many :image
  has_many :category_items
  has_many :categories, through: :category_items
end
