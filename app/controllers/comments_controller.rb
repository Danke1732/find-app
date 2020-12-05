class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @article = Article.find_by(id: params[:article_id])
    if @comment.valid?
      @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment, user: @comment.user
    else
      @error_message = @comment.errors.full_messages
      ActionCable.server.broadcast 'comment_channel', error_message: @error_message
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
