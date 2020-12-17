class CommentsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    @comment = Comment.new(comment_params)
    @article = Article.find_by(id: params[:article_id])
    if @comment.valid?
      @comment.save
      @date = Date.current.strftime('%Y年 %m月 %d日')
      ActionCable.server.broadcast 'comment_channel', content: @comment, user: @comment.user, date: @date
    else
      @error_message = @comment.errors.full_messages
      ActionCable.server.broadcast 'comment_channel', error_message: @error_message
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    @comment = Comment.find_by(id: params[:id])
    render json: { comment: @comment }
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
