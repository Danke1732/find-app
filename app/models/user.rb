class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :article_marks, through: :bookmarks, source: :article
  has_many :notes
  has_one :profile

  validates :nickname, presence: true
end
