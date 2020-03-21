class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :pref
  belongs_to_active_hash :deliverycost
  belongs_to_active_hash :delivery_days
  belongs_to_active_hash :boughtflg
  # 上記active_hashのアソシエーション
  validate :images_presence  #, length: {manimum: 1, maximum: 10}
  validates :name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :boughtflg_id, presence: true
  validates :price, presence: true, inclusion: 300..9999999

  has_many_attached :images
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :category


  # def images_presence
  #   unless images.attached?
  #     errors.add(:image, '画像がありません')
  #   end
  # end


  def images_presence
    if images.attached?
      # inputに保持されているimagesがあるかを確認
      if images.length > 10
        errors.add(:image, '10枚まで投稿できます')
      end
    else
      errors.add(:image, '画像がありません')
    end
  end
end