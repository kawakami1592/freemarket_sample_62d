class Item < ApplicationRecord
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :deliverycost
  belongs_to_active_hash :delivery_days
  belongs_to_active_hash :birthyear
  belongs_to_active_hash :birthmonth
  belongs_to_active_hash :birthday
# 上記active_hashのアソシエーション

  has_many :image
  has_many :category_items
  has_many :categorys, through: :category_items
end
