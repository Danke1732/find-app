class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_category_parent_array, only: [:new, :create]

  def index
    @articles = Article.includes(:user).order('updated_at DESC').page(params[:page]).per(8)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.valid?
      @article.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def show
    @article = Article.find(params[:id])
    get_category_path_name
  end

  def get_category_children
    @category_children = Category.find_by(id: "#{params[:id]}", ancestry: nil).children
    render json: { children: @category_children }
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:id]}").children
    render json: { grandChildren: @category_grandchildren }
  end

  private

  def article_params
    params.require(:article).permit(:image, :title, :category_id, :text).merge(user_id: current_user.id)
  end

  def set_category_parent_array
    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent
    end
  end

  def get_category_path_name
    @article_categories = Category.find_by(id: @article.category_id).path_ids
    @article_category_name = []
    @article_categories.each do |category|
      category_name = Category.find_by(id: category)
      @article_category_name << category_name.name
    end
  end

end
