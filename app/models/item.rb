class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :pref
  belongs_to_active_hash :deliverycost
  belongs_to_active_hash :delivery_days
  belongs_to_active_hash :boughtflg
  
# 上記active_hashのアソシエーション

  has_many_attached :images
  belongs_to :user, foreign_key: 'user_id',optional: true
  # ,optional: true後で消す　belongs_toのnotnull制約解放のため使用している
  belongs_to :category,optional: true

end