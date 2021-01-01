class UsersController < ApplicationController
  def index
    @users = User.includes(:articles, :profile).order('updated_at DESC').page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.with_attached_image
    @articles = Kaminari.paginate_array(@user.articles).page(params[:page]).per(8)
    @articles_bookmarks = Kaminari.paginate_array(@user.article_marks).page(params[:page]).per(8)
    @user_notes = @user.notes.order('created_at DESC')
  end
end
