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

  def self.get_category_path_name(article)
    @article_categories = Category.find_by(id: article.category_id).path_ids
    @article_category_name = []
    @article_categories.each do |category|
      category_name = Category.find_by(id: category)
      @article_category_name << category_name
    end
    
    @article_category_name
  end

  def self.set_edit_category_array(article)
    grandchild_category = article.category
    child_category = grandchild_category.parent

    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end

    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end

    [@category_children_array, @category_grandchildren_array]
  end
end
