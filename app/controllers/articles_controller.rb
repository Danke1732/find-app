class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_category_parent_array, only: [:new, :create, :edit, :update]
  before_action :article_user_check, only: [:edit, :update, :destroy]

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
    get_category_path_name
    @comment = Comment.new
    @comments = @article.comments.includes(:user).order('created_at ASC')
    bookmark_status = Bookmark.find_by(article_id: params[:id], user_id: current_user.id)
    if bookmark_status
      @bookmark = "true"
      @bookmark_check = "外す"
    else
      @bookmark = "false"
      @bookmark_check = "する"
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      @article.save
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to action: :index
  end

  def search
    if params[:keyword] != ''
      @keyword = params[:keyword]
      @article = []
      @split_keywords = params[:keyword].split(/[[:blank:]]+/)
      keyword_search
      @articles = Kaminari.paginate_array(@article).page(params[:page]).per(8)
    else
      @articles = Article.includes(:user).order('updated_at DESC').page(params[:page]).per(8)
    end
  end

  def get_category_children
    @category_children = Category.find_by(id: params[:id].to_s, ancestry: nil).children
    render json: { children: @category_children }
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:id].to_s).children
    render json: { grandChildren: @category_grandchildren }
  end

  private

  def article_params
    params.require(:article).permit(:image, :title, :category_id, :text).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
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

  def article_user_check
    redirect_to root_path unless current_user.id == @article.user_id
  end

  def keyword_search
    @split_keywords.each do |keyword|
      Article.where('title LIKE(?) OR text LIKE(?)', "%#{keyword}%", "%#{keyword}%").each do |answer|
        @article.push(answer)
      end
    end
  end
end
