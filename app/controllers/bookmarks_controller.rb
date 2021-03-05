class BookmarksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: :like

  def index
    @user = User.find_by(id: params[:user_id])
    redirect_to root_path if current_user.id != @user.id
    @articles = @user.article_marks.includes(:user).order('created_at DESC').with_attached_image.page(params[:page]).per(8)
  end

  def like
    bookmark = Bookmark.find_by(article_id: params[:id], user_id: current_user.id)
    if bookmark
      bookmark.destroy
    else
      bookmark = Bookmark.new(article_id: params[:id], user_id: current_user.id)
      bookmark.save
    end
    bookmark_after = Bookmark.find_by(article_id: params[:id], user_id: current_user.id)
    registration = Bookmark.like_ajax(bookmark_after)
    render json: { bookmark: bookmark_after, registration: registration }
  end
end
