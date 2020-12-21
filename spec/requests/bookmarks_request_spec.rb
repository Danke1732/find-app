require 'rails_helper'

RSpec.describe 'Bookmarks', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @article =FactoryBot.create(:article)
  end

  describe 'GET #index' do
    context 'ログインしているとき' do
      it 'リクエストを送ると正常にレスポンスが返ってくる' do
        sign_in @user
        get user_bookmarks_path(@user.id)
        expect(response.status).to eq 200
      end
      it 'indexアクションにリクエストするとレスポンスに「ユーザー名さんのブックマーク記事」が表示されている' do
        sign_in @user
        get user_bookmarks_path(@user.id)
        expect(response.body).to include "#{@user.nickname}さんのブックマーク記事"
      end
    end

    context 'ログインしていないとき' do
      it 'ログイン画面へリダイレクトする' do
        get user_bookmarks_path(@user.id)
        expect(response.body).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create, #destroy' do
    context 'ログインしているとき' do
      it 'ブックマークをしていないとき、ブックマーク登録ができること' do
        sign_in @user2
        get article_path(@article.id)
        expect do
          post "/bookmarks/#{@article.id}", params: { bookmark: { user_id: @user.id, article_id: @article.id }}, xhr: true
        end.to change(Bookmark, :count).by(1)
      end
      it 'ブックマークをしているとき、ブックマーク登録を外すことができること' do
        @bookmark = Bookmark.create(user_id: @user2.id, article_id: @article.id)
        sign_in @user2
        get article_path(@article.id)
        expect do
          post "/bookmarks/#{@article.id}", params: { bookmark: { user_id: @user.id, article_id: @article.id }}, xhr: true
        end.to change(Bookmark, :count).by(-1)
      end
    end    

    context 'ログインしていないとき' do
      it 'ログイン画面へリダイレクトする' do
        get user_bookmarks_path(@user.id)
        expect(response.body).to redirect_to new_user_session_path
      end
    end
  end
end
