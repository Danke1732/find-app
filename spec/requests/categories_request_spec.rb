require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before do
    # カテゴリー選択用
    work = Category.create(id: 1, name: '仕事・仕事術')
    work_1 = work.children.create(id: 2, name: '効率')
    work_1.children.create([{ id: 3, name: 'ツール' }, { id: 4, name: 'マインド' }, { id: 5, name: 'その他' }])
    work_2 = work.children.create(id: 6, name: 'IT・メディア')
    work_2.children.create([{ id: 7, name: '通信' }, { id: 8, name: 'IT' }, { id: 9, name: 'ソフトウェア' }, { id: 10, name: 'インターネット' }, { id: 11, name: 'テレビ' }, { id: 12, name: 'その他' }])
    work_3 = work.children.create(name: '時短術')
    work_3.children.create([{ id: 13, name: '道具' }, { id: 14, name: '考え方' }, { id: 15, name: 'その他' }])

    health = Category.create(id: 16, name: '健康')
    health_1 = health.children.create(id: 17, name: '運動')
    health_1.children.create([{ id: 18, name: 'ランニング' }, { id: 19, name: 'ストレッチ' }, { id: 20, name: 'その他' }])
    health_2 = health.children.create(id: 21, name: '食生活')
    health_2.children.create([{ id: 22, name: 'お肉' }, { id: 23, name: '野菜' }, { id: 24, name: '魚' }, { id: 25, name: 'その他' }])
    # ユーザー及び記事作成
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @user3 = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user.id, category_id: 3)
    @article2 = FactoryBot.create(:article_test, user_id: @user2.id, image: fixture_file_upload('public/images/test-image2.jpg'), category_id: 3)
    @article3 = FactoryBot.create(:article, user_id: @user3.id, category_id: 22)
  end

  describe 'GET categories#index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get categories_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに「Category List」の文字が含まれている' do
      get categories_path
      expect(response.body).to include 'Category List'
    end
    it 'indexアクションにリクエストするとレスポンスに各カテゴリー名が含まれている' do
      get categories_path
      expect(response.body).to include '仕事・仕事術'
      expect(response.body).to include '効率'
      expect(response.body).to include 'ツール'

      expect(response.body).to include '健康'
      expect(response.body).to include '運動'
      expect(response.body).to include 'ランニング'

      expect(response.body).to include '食生活'
      expect(response.body).to include 'その他'
    end
  end

  describe 'GET categories#show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get category_path(@article.category_id)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに選択したカテゴリーidの記事のタイトルが存在する' do
      get category_path(@article.category_id)
      expect(response.body).to include @article.title
      expect(response.body).to include @article2.title
      expect(response.body).to_not include @article3.title
    end
    it 'showアクションにリクエストするとレスポンスに選択したカテゴリーidの記事の投稿者名が存在する' do
      get category_path(@article.category_id)
      expect(response.body).to include @article.user.nickname
      expect(response.body).to include @article2.user.nickname
      expect(response.body).to_not include @article3.user.nickname
    end
    it 'showアクションにリクエストするとレスポンスに選択したカテゴリーidの記事の画像が存在する' do
      get category_path(@article.category_id)
      expect(response.body).to include 'test-image.jpg'
      expect(response.body).to include 'test-image2.jpg'
    end
  end
end
