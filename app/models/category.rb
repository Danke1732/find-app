class Category < ApplicationRecord
  has_many :articles
  has_ancestry

  def set_articles
    if self.root?
      start_id = self.indirects.first.id
      end_id = self.indirects.last.id
      articles = Article.where(category_id: start_id..end_id)
      return articles
    elsif self.has_children?
      start_id = self.children.first.id
      end_id = self.children.last.id
      articles = Article.where(category_id: start_id..end_id)
      return articles
    else
      return self.articles
    end
  end
end
