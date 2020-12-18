class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @articles = Kaminari.paginate_array(@user.articles).page(params[:page]).per(8)
    @articles_bookmarks = Kaminari.paginate_array(@user.article_marks).page(params[:page]).per(8)
    @user_notes = @user.notes.order('created_at DESC')
  end
end
