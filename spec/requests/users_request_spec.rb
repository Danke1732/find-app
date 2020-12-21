require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article)
  end
  describe 'GET #index' do
    it 'リクエストを送ると正常にレスポンスが返ってくる' do
      get users_path
      expect(response.status).to eq 200
    end
    it 'リクエストを送るとレスポンスに「User List」の文字が含まれている' do
      get users_path
      expect(response.body).to include 'User List'
    end
  end

  describe 'GET #show' do
    it 'リクエストを送ると正常にレスポンスが返ってくる' do
      get user_path(@user.id)
      expect(response.status).to eq 200
    end
    it 'リクエストを送ると正常にレスポンスに「ユーザー名さんの投稿記事が含まれている」' do
      get user_path(@user)
      expect(response.body).to include "#{@user.nickname}さんの投稿記事"
    end
  end
end
