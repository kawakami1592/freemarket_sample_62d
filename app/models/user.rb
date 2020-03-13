class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birthyear
  belongs_to_active_hash :birthmonth
  belongs_to_active_hash :birthday

  validates :lastname,:firstname,:lastname_kana,:firstname_kana, 
  format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  devise :database_authenticatable, :registerable
end