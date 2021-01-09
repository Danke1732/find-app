class CategoriesController < ApplicationController
  before_action :set_category, only: :show

  def index
    @parent_categories = Category.where(ancestry: nil)
  end

  def show
    articles = @category.set_articles
    @articles = articles.preload(:user).order('updated_at DESC').with_attached_image.page(params[:page]).per(8)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
