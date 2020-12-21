require 'rails_helper'

RSpec.describe 'DeviseUsers', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user_params = FactoryBot.attributes_for(:user)
    @invalid_user_params = FactoryBot.attributes_for(:user, nickname: '')
  end

  describe 'POST registrations#create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: @user_params }
        expect(response.status).to eq 302
      end
      it 'リダイレクトされること' do
        post user_registration_path, params: { user: @user_params }
        expect(response).to redirect_to root_path
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: @invalid_user_params }
        expect(response.status).to eq 200
      end
      it 'エラーが表示されること' do
        post user_registration_path, params: { user: @invalid_user_params }
        expect(response.body).to include 'ニックネームを入力してください'
      end
    end
  end

  describe 'GET registrations#new' do
    it 'リクエストが成功すること' do
      get new_user_registration_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET sessions#new' do
    it 'リクエストが成功すること' do
      get new_user_session_path
      expect(response.status).to eq 200
    end
  end

  describe 'POST sessions#create' do
    it 'リクエストが成功すること' do
      post user_session_path, params: { user: { email: @user.email, password: @user.password } }
      expect(response.status).to eq 302
    end
    it 'リダイレクトされること' do
      post user_session_path, params: { user: { email: @user.email, password: @user.password } }
      expect(response.status).to redirect_to root_path
    end
  end

  describe 'DELETE sessions#destroy' do
    it 'リクエストが成功すること' do
      sign_in @user
      delete destroy_user_session_path
      expect(response).to redirect_to root_path
    end
  end
end
