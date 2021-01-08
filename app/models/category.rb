class Category < ApplicationRecord
  has_many :articles
  has_ancestry

  def set_articles
    if root?
      start_id = indirects.first.id
      end_id = indirects.last.id
      Article.where(category_id: start_id..end_id)

    elsif has_children?
      start_id = children.first.id
      end_id = children.last.id
      Article.where(category_id: start_id..end_id)

    else
      articles
    end
  end
end
