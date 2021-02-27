class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks

  with_options presence: true do
    validates :image
    validates :title
    validates :text
  end

  def previous
    Article.where('id < ?', id).order('id DESC').first
  end

  def next
    Article.where('id > ?', id).order('id ASC').first
  end

  def new_arrival?
    created_at + 3.days > Date.today
  end

  def self.keyword_search(keywords)
    articles = []
    keywords.each do |keyword|
      Article.where('title LIKE(?) OR text LIKE(?)', "%#{keyword}%", "%#{keyword}%").eager_load(:user).with_attached_image.each do |answer|
        articles.push(answer)
      end
    end
    articles
  end
end
