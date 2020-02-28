class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :pref
  belongs_to_active_hash :deliverycost
  belongs_to_active_hash :delivery_days
# 上記active_hashのアソシエーション

  has_many_attached :images
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :category

end
