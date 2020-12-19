class Profile < ApplicationRecord
  belongs_to :user

  validates :hobby, length: { maximum: 140 }
  validates :favorite_word, length: { maximum: 140 }
end
