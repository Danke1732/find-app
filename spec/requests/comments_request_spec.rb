require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article)
  end

  describe 'POST #create' do
    context 'ログインしているとき' do
      it 'リクエストを送るとコメントが登録される' do
        sign_in @user
        expect do
          post article_comments_path(@article.id), params: { comment: { text: "test", user_id: @user.id, article_id: @article.id }}, xhr: true
        end.to change(Comment, :count).by(1)
      end
    end
    context 'ログインしていないとき' do
      it 'ログイン画面へリダイレクトする' do
        post article_comments_path(@article.id), params: { comment: { text: "test", user_id: @user.id, article_id: @article.id }}, xhr: true
        expect(response.body).to include 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしているとき' do
      it 'リクエストを送るとコメントが削除される' do
        @comment = Comment.create(text: "test", user_id: @user.id, article_id: @article.id)
        sign_in @user
        expect do
          delete article_comment_path(@article.id, @comment.id), xhr: true
        end.to change(Comment, :count).by(-1)
      end
    end
    context 'ログインしていないとき' do
      it 'ログイン画面へリダイレクトする' do
        post article_comments_path(@article.id), params: { comment: { text: "test", user_id: @user.id, article_id: @article.id }}, xhr: true
        expect(response.body).to include 'アカウント登録もしくはログインしてください。'
      end
    end
  end
end
