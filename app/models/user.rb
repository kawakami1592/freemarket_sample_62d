class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :lastname,:firstname,:lastname_kana,:firstname_kana, 
  format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
