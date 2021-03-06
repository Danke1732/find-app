class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_category_parent_array, only: [:new, :create, :edit, :update]
  before_action :article_user_check, only: [:edit, :update, :destroy]

  def index
    @articles = Article.includes(:user).with_attached_image.order('updated_at DESC').page(params[:page]).per(8)
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
    @articles = @article.user.articles.where.not(id: @article.id).with_attached_image.order('RAND()').limit(3)
    @article_category_name = Category.get_category_path_name(@article)
    @comment = Comment.new
    @comments = @article.comments.includes(:user).order('created_at ASC')
    bookmark_status = Bookmark.find_by(article_id: params[:id], user_id: current_user.id) if user_signed_in?
    @bookmark = Bookmark.status(bookmark_status)[0]
    @bookmark_check = Bookmark.status(bookmark_status)[1]
  end

  def edit
    @category_children_array = Category.set_edit_category_array(@article)[0]
    @category_grandchildren_array = Category.set_edit_category_array(@article)[1]
  end

  def update
    @category_children_array = Category.set_edit_category_array(@article)[0]
    @category_grandchildren_array = Category.set_edit_category_array(@article)[1]
    @article.update(article_params)
    if @article.valid?
      @article.save
      redirect_to action: :index
    else
      @article.category_id = Article.find(params[:id]).category_id
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
      @split_keywords = params[:keyword].split(/[[:blank:]]+/)
      @article = Article.keyword_search(@split_keywords)
      @articles = Kaminari.paginate_array(@article).page(params[:page]).per(8)
    else
      @articles = Article.includes(:user).with_attached_image.order('updated_at DESC').page(params[:page]).per(8)
    end
  end

  def ranking
    @articles = Article.joins(:bookmarks).preload(:user, :bookmarks).with_attached_image.group(:article_id).order('count(article_id) DESC').page(params[:page]).per(8)
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

  def article_user_check
    redirect_to root_path unless current_user.id == @article.user_id
  end
end
