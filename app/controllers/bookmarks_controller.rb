class BookmarksController < ApplicationController
  def like
    bookmark = Bookmark.find_by(article_id: params[:id], user_id: current_user.id)
    if bookmark
      bookmark.destroy
    else
      bookmark = Bookmark.new(article_id: params[:id], user_id: current_user.id)
      bookmark.save
    end
    bookmark_after = Bookmark.find_by(article_id: params[:id], user_id: current_user.id)
    registration = if bookmark_after
                     '登録済み'
                   else
                     '登録する'
                   end
    render json: { bookmark: bookmark_after, registration: registration }
  end
end
