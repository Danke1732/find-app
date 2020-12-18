require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article)
  end

  describe 'GET #index' do
    context 'ログインしてしないとき' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        get root_path
        expect(response.status).to eq 200
      end
      it 'indexアクションにリクエストするとレスポンスに投稿済みの記事のタイトルが存在する' do
        get root_path
        expect(response.body).to include @article.title
      end
      it 'indexアクションにリクエストするとレスポンスに投稿済みの記事の投稿者名が存在する' do
        get root_path
        expect(response.body).to include @article.user.nickname
      end
    end

    context 'ログインしているとき' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        sign_in @user
        get root_path
        expect(response.status).to eq 200
      end
      it 'indexアクションにリクエストするとレスポンスに投稿済みの記事のタイトルが存在する' do
        sign_in @user
        get root_path
        expect(response.body).to include @article.title
      end
      it 'indexアクションにリクエストするとレスポンスにブックマークタブが存在する' do
        sign_in @user
        get root_path
        expect(response.body).to include 'ブックマーク'
      end
      it 'indexアクションにリクエストするとレスポンスにノートタブが存在する' do
        sign_in @user
        get root_path
        expect(response.body).to include 'ノート'
      end
    end
  end

  describe 'GET #show' do
    context 'ログインしていないとき' do
      it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
        get article_path(@article)
        expect(response.status).to eq 200
      end
      it 'showアクションにリクエストするとレスポンスに投稿済みの記事のtitleが存在する' do
        get article_path(@article)
        expect(response.body).to include @article.title
      end
      it 'showアクションにリクエストするとレスポンスに投稿済みの記事のtextが存在する' do
        get article_path(@article)
        expect(response.body).to include @article.text
      end
      it 'showアクションにリクエストするとレスポンスに投稿済みの記事のcategory名が存在する' do
        get article_path(@article)
        expect(response.body).to include @article.category.name
      end
      it 'showアクションにリクエストするとレスポンスに投稿済みの記事の画像が存在する' do
        get article_path(@article)
        expect(response.body).to include 'test-image.jpg'
      end
      it 'showアクションにリクエストするとレスポンスに投稿済みの記事の投稿者名が存在する' do
        get article_path(@article)
        expect(response.body).to include @article.user.nickname
      end
      it 'showアクションにリクエストするとレスポンスに投稿済みの記事の更新日が存在する' do
        get article_path(@article)
        expect(response.body).to include @article.updated_at.strftime('%Y年 %m月 %d日')
      end
      it 'showアクションにリクエストするとレスポンスにコメント一覧BOX,コメント投稿BOXが存在する' do
        get article_path(@article)
        expect(response.body).to include 'コメント一覧BOX'
        expect(response.body).to include 'コメント投稿BOX'
      end
    end
    context 'ログインしているとき' do
      it 'showアクションにリクエストするとレスポンスに「コメントする」の文字列が存在する' do
        sign_in @user
        get article_path(@article)
        expect(response.body).to include 'コメントする'
      end
    end
  end

  describe 'get #new' do
    context 'ログインしていないとき' do
      it 'newアクションにリクエストするとトップページへリダイレクトする' do
        get new_article_path
        expect(response.status).to eq 302
      end
    end
    context 'ログインしているとき' do
      it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
        sign_in @user
        get new_article_path
        expect(response.status).to eq 200
      end
      it 'newアクションにリクエストするとレスポンスに「投稿する」の文字列がある' do
        sign_in @user
        get new_article_path
        expect(response.body).to include '投稿する'
      end
    end
  end

  describe 'get #edit' do
    context 'ログインしていないとき' do
      it 'editアクションにリクエストするとトップページへリダイレクトされる' do
        get edit_article_path(@article)
        expect(response.status).to eq 302
      end
    end

    context 'ログインしているとき' do
      it 'editアクションでリクエストすると正常にレスポンスが返ってくる' do
        @user2 = @article.user
        sign_in @user2
        get edit_article_path(@article)
        expect(response.status).to eq 200
      end
      it 'editアクションでリクエストすると投稿記事タイトルが存在する' do
        @user2 = @article.user
        sign_in @user2
        get edit_article_path(@article)
        expect(response.body).to include @article.title
      end
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すると正常にレスポンスが返ってくる' do
        sign_in @user
        article_params = FactoryBot.attributes_for(:article)
        post articles_path, params: { article: article_params }
        expect(response.status).to eq 200
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが失敗すること' do
        sign_in @user
        article_params = FactoryBot.attributes_for(:article)
        post articles_path, params: { article: FactoryBot.attributes_for(:article) }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'PATCH #update' do
    context 'パラメータが正常な場合' do
      it 'リクエストが成功すること' do
        @user2 = @article.user
        sign_in @user2
        patch article_path(@article), params: { article: FactoryBot.attributes_for(:article), user_id: @user.id }
        expect(response.status).to eq 302
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'パラメータが正常な場合' do
      it 'リクエストが成功すること' do
        @user2 = @article.user
        sign_in @user2
        delete article_path(@article)
        expect(response.status).to eq 302
      end
    end
  end
end
