require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @profile = FactoryBot.create(:profile)
    @profile_params = FactoryBot.attributes_for(:profile)
  end

  describe 'GET #show' do
    context 'ログインしているとき' do
      it 'リクエストを送ると正常なレスポンスが返ってくる' do
        sign_in @user
        get user_profiles_path(@user2)
        expect(response.status).to eq 200
      end
      it 'showアクションにリクエストを送るとレスポンスにニックネームにユーザー名が含まれている' do
        sign_in @user
        get user_profiles_path(@user2)
        expect(response.body).to include "#{@user.nickname}"
      end
      it 'showアクションにリクエストを送るとレスポンスに「趣味」が含まれている' do
        sign_in @user
        get user_profiles_path(@user2)
        expect(response.body).to include '趣味'
      end
      it 'showアクションにリクエストを送るとレスポンスに「好きな言葉」が含まれている' do
        sign_in @user
        get user_profiles_path(@user2)
        expect(response.body).to include '好きな言葉'
      end
      it 'showアクションにリクエストを送るとレスポンスに「自己紹介」が含まれている' do
        sign_in @user
        get user_profiles_path(@user2)
        expect(response.body).to include '自己紹介'
      end
    end

    context 'ログインしていないとき' do
      it 'リクエストに成功する' do
        get user_profiles_path(@user2)
        expect(response.status).to eq 302
      end
      it 'リダイレクトされる' do
        get user_profiles_path(@user2)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'ログインしているとき' do
      it 'createアクションにリクエストを送ると正常なレスポンスが返ってくる' do
        sign_in @user
        post profiles_path, params: { profile: @profile_params, user_id: @user.id }
        expect(response.status).to eq 302
      end
      it 'createアクションにリクエストを送るとprofileが登録される' do
        sign_in @user
        expect do
          post profiles_path, params: { profile: @profile_params, user_id: @user.id }
        end.to change(Profile, :count).by(1)
      end
      it 'プロフィール詳細画面へリダイレクトされる' do
        sign_in @user
        post profiles_path, params: { profile: @profile_params, user_id: @user.id }
        expect(response).to redirect_to user_profiles_path(@user)
      end
    end

    context 'ログインしていないとき' do
      it 'リクエストに成功する' do
        post profiles_path, params: { profile: @profile_params, user_id: "" }
        expect(response.status).to eq 302
      end
      it 'リダイレクトされる' do
        post profiles_path, params: { profile: @profile_params, user_id: "" }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #new' do
    context 'ログインしているとき' do
      it 'newアクションにリクエストを送ると正常なレスポンスが返ってくる' do
        sign_in @user
        get new_profile_path
        expect(response.status).to eq 200
      end
    end

    context 'ログインしていないとき' do
      it 'リクエストに成功する' do
        get new_profile_path
        expect(response.status).to eq 302
      end
      it 'リダイレクトされる' do
        get new_profile_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインしているとき' do
      it 'editアクションにリクエストすると正常なレスポンスが返ってくる' do
        sign_in @user
        @profile2 = Profile.create(hobby: 'test', favorite_word: 'test', introduction: 'test', user_id: @user.id )
        get user_profiles_edit_path(@profile2.user_id)
        expect(response.status).to eq 200
      end
      it 'editアクションにリクエストするとレスポンスに「更新する」が含まれている' do
        sign_in @user
        @profile2 = Profile.create(hobby: 'test', favorite_word: 'test', introduction: 'test', user_id: @user.id )
        get user_profiles_edit_path(@profile2.user_id)
        expect(response.body).to include '更新する'
      end
    end
    context 'ログインしていないとき' do
      it 'リクエストに成功する' do
        get user_profiles_edit_path(@user)
        expect(response.status).to eq 302
      end
      it 'リダイレクトされる' do
        get user_profiles_edit_path(@user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログインしているとき' do
      it 'updateアクションにリクエストすると正常なレスポンスが返ってくる' do
        sign_in @user
        @profile2 = Profile.create(hobby: 'test', favorite_word: 'test', introduction: 'test', user_id: @user.id )
        patch user_profiles_update_path(@profile2.user_id), params: { profile: @profile_params, user_id: @user.id }
        expect(response.status).to eq 302
      end
      it 'リダイレクトされる' do
        sign_in @user
        @profile2 = Profile.create(hobby: 'test', favorite_word: 'test', introduction: 'test', user_id: @user.id )
        patch user_profiles_update_path(@profile2.user_id), params: { profile: @profile_params, user_id: @user.id }
        expect(response).to redirect_to user_profiles_path(@profile2.user_id)
      end
    end
    context 'ログインしていないとき' do
      it 'リクエストに成功する' do
        @profile2 = Profile.create(hobby: 'test', favorite_word: 'test', introduction: 'test', user_id: @user.id )
        patch user_profiles_update_path(@profile2.user_id), params: { profile: @profile_params, user_id: @user.id }
        expect(response.status).to eq 302
      end
      it 'リダイレクトされる' do
        @profile2 = Profile.create(hobby: 'test', favorite_word: 'test', introduction: 'test', user_id: @user.id )
        patch user_profiles_update_path(@profile2.user_id), params: { profile: @profile_params, user_id: '' }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
