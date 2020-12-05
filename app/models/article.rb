class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :image
    validates :title
    validates :text
  end
end
