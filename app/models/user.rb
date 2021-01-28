class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  with_options presence: true, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}+\z/i , message: '英数字混合6文字以上' } do
    validates :password
  end


  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: '全角漢字・かな・カタカナを使用してください' } do
    validates :last_name_kanji
    validates :first_name_kanji
  end
 
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナを使用してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end

  validates :birth_id, presence: true

  has_many :products
  has_many :orders
end
