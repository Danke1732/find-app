class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :category

  with_options presence: true do
    validates :image
    validates :title
    validates :text
  end
end
