class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birthyear
  belongs_to_active_hash :birthmonth
  belongs_to_active_hash :birthday
  has_many :items

  validates :lastname,:firstname,:lastname_kana,:firstname_kana, 
  format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :nickname,:encrypted_password,:password_confirmation,:lastname,:firstname,:zipcode,:pref,:city,:address,:lastname_kana,:firstname_kana,:birthyear_id,:birthmonth_id,:birthday_id, presence: true
  validates :encrypted_password,:password_confirmation, length: {minimum: 7}
  validates :email, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end