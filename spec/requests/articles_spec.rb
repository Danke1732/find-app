require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @article = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article, user_id: @user2.id)
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
      it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
        sign_in @user
        get article_path(@article)
        expect(response.status).to eq 200
      end
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
      it 'editアクションでリクエストすると投稿記事タイトルがすでに存在する' do
        @user2 = @article.user
        sign_in @user2
        get edit_article_path(@article)
        expect(response.body).to include @article.title
      end
      it 'editアクションでリクエストすると投稿記事テキストがすでに存在する' do
        @user2 = @article.user
        sign_in @user2
        get edit_article_path(@article)
        expect(response.body).to include @article.text
      end
      it 'editアクションでリクエストすると投稿記事の画像がすでに存在する' do
        @user2 = @article.user
        sign_in @user2
        get edit_article_path(@article)
        expect(response.body).to include 'test-image.jpg'
      end
    end
  end

  describe 'POST #create' do
    before do
      # カテゴリー選択用
      work = Category.create(id: 1, name: '仕事・仕事術')
      work_1 = work.children.create(id: 2, name: '効率')
      work_1.children.create([{ id: 3, name: 'ツール' }, { id: 4, name: 'マインド' }, { id: 5, name: 'その他' }])
    end

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すると正常にレスポンスが返ってくる' do
        sign_in @user
        article_params = FactoryBot.attributes_for(:article_test, image: fixture_file_upload('public/images/test-image.jpg'), user_id: @user.id)
        post articles_path, params: { article: article_params }
        expect(response.status).to eq 302
      end
      it '記事が登録されること' do
        sign_in @user
        article_params = FactoryBot.attributes_for(:article_test, image: fixture_file_upload('public/images/test-image.jpg'), user_id: @user.id)
        expect do
          post articles_path, params: { article: article_params }
        end.to change(Article, :count).by(1)
      end
      it 'リダイレクトされること' do
        sign_in @user
        article_params = FactoryBot.attributes_for(:article_test, image: fixture_file_upload('public/images/test-image.jpg'), user_id: @user.id)
        post articles_path, params: { article: article_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが失敗すること' do
        sign_in @user
        invalid_article_params = FactoryBot.attributes_for(:article_test, image: fixture_file_upload('public/images/test-image.jpg'), title: '', user_id: @user.id)
        post articles_path, params: { article: invalid_article_params }
        expect(response.status).to eq 200
      end
      it '記事が登録されないこと' do
        sign_in @user
        invalid_article_params = FactoryBot.attributes_for(:article_test, image: fixture_file_upload('public/images/test-image.jpg'), title: '', user_id: @user.id)
        expect do
          post articles_path, params: { article: invalid_article_params }
        end.to_not change(Article, :count)
      end
      it 'エラーが表示されること' do
        sign_in @user
        invalid_article_params = FactoryBot.attributes_for(:article_test, image: fixture_file_upload('public/images/test-image.jpg'), title: '', user_id: @user.id)
        post articles_path, params: { article: invalid_article_params }
        expect(response.body).to include 'タイトルを入力してください'
      end
    end
  end

  describe 'PATCH #update' do
    before do
      # カテゴリー選択用
      work = Category.create(id: 1, name: '仕事・仕事術')
      work_1 = work.children.create(id: 2, name: '効率')
      work_1.children.create([{ id: 3, name: 'ツール' }, { id: 4, name: 'マインド' }, { id: 5, name: 'その他' }])
    end

    context 'パラメータが正常な場合' do
      it 'リクエストが成功すること' do
        sign_in @user2
        article_params = FactoryBot.attributes_for(:article_test, image: fixture_file_upload('public/images/test-image.jpg'), user_id: @user2.id)
        patch article_path(@article2), params: { article: article_params }
        expect(response.status).to eq 302
      end
      it '記事内容が更新されること' do
        sign_in @user2
        article_params = FactoryBot.attributes_for(:article_test, image: fixture_file_upload('public/images/test-image.jpg'), user_id: @user2.id)
        expect do
          patch article_path(@article2), params: { article: article_params }
        end.to change { Article.find(@article2.id).text }.from(@article2.text).to('testtest')
      end
      it 'リダイレクトされる' do
        sign_in @user2
        article_params = FactoryBot.attributes_for(:article_test, image: fixture_file_upload('public/images/test-image.jpg'), user_id: @user2.id)
        patch article_path(@article2), params: { article: article_params }
        expect(response).to redirect_to root_path
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが失敗すること' do
        sign_in @user2
        invalid_article_params = FactoryBot.attributes_for(:article_test, title: '')
        post articles_path, params: { article: invalid_article_params, image: fixture_file_upload('public/images/test-image.jpg'), user_id: @user2.id }
        expect(response.status).to eq 200
      end
      it '記事内容が更新されないこと' do
        sign_in @user2
        invalid_article_params = FactoryBot.attributes_for(:article_test, title: '')
        expect do
          post articles_path, params: { article: invalid_article_params, image: fixture_file_upload('public/images/test-image.jpg'), user_id: @user2.id }
        end.to_not change(Article.find(@article2.id), :title)
      end
      it 'エラーが表示されること' do
        sign_in @user2
        invalid_article_params = FactoryBot.attributes_for(:article_test, title: '')
        post articles_path, params: { article: invalid_article_params, image: fixture_file_upload('public/images/test-image.jpg'), user_id: @user2.id }
        expect(response.body).to include 'タイトルを入力してください'
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'リクエストが成功すること' do
      sign_in @user2
      delete article_path(@article2)
      expect(response.status).to eq 302
    end
    it '記事が削除されること' do
      sign_in @user2
      expect do
        delete article_path(@article2)
      end.to change(Article, :count).by(-1)
    end
    it 'トップページにリダイレクトされる' do
      sign_in @user2
      delete article_path(@article2)
      expect(response).to redirect_to root_path
    end
  end
end
