class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :pref
  belongs_to_active_hash :deliverycost
  belongs_to_active_hash :delivery_days
  belongs_to_active_hash :boughtflg
  # 上記active_hashのアソシエーション
  validate :images_presence
  validates :name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :boughtflg_id, presence: true
  validates :price, presence: true, inclusion: 300..9999999

  has_many_attached :images
  # attribute :new_image
  # attribute :remove_images, :boolean

  belongs_to :user, foreign_key: 'user_id'
  belongs_to :category

  # before_save do
  #   if new_images
  #     self.images = new_images
  #     # self.profile_picture.attach(new_profile_picture) でも可
  #   elsif remove_profile_picture
  #     self.images.purge
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

  # validate if: :new_images do
  #   if new_images.respond_to?(:content_type)
  #     unless new_images.content_type.in?(ALLOWED_CONTENT_TYPES)
  #       errors.add(:new_images, :invalid_image_type)
  #     end
  #   else
  #     errors.add(:new_images, :invalid)
  #   end
  # end



end