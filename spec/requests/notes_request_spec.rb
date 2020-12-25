require 'rails_helper'

RSpec.describe 'Notes', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @note = FactoryBot.create(:note, user_id: @user.id)
  end

  describe 'GET #index' do
    context 'ログインしているとき' do
      it 'リクエストを送ると正常なレスポンスが返ってくる' do
        sign_in @user
        get user_notes_path(@user.id)
        expect(response.status).to eq 200
      end
      it 'リクエストを送るとレスポンスに「Note page」の文字が含まれている' do
        sign_in @user
        get user_notes_path(@user.id)
        expect(response.body).to include 'Note page'
      end
    end

    context 'ログインしていないとき' do
      it 'ログイン画面へリダイレクトする' do
        get user_notes_path(@user.id)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'メモ投稿者自身のページにのみしかメモ一覧ページへ遷移できない' do
      it 'トップページにリダイレクトする' do
        sign_in @user2
        get user_notes_path(@user.id)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    context 'ログインしているとき' do
      it 'リクエストを送るとメモが登録される' do
        sign_in @user
        expect do
          post notes_path, params: { note: { text: 'test', user_id: @user.id } }, xhr: true
        end.to change(Note, :count).by(1)
      end
    end

    context 'ログインしていないとき' do
      it 'ログイン画面へリダイレクトする' do
        post notes_path, params: { note: { text: 'test', user_id: @user.id } }, xhr: true
        expect(response.body).to include 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしているとき' do
      it 'リクエストを送るとメモが削除される' do
        @note = Note.create(text: 'test', user_id: @user.id)
        sign_in @user
        expect do
          delete note_path(@note.id), xhr: true
        end.to change(Note, :count).by(-1)
      end
    end

    context 'ログインしていないとき' do
      it 'ログイン画面へリダイレクトする' do
        post notes_path, params: { note: { text: 'test', user_id: @user.id } }, xhr: true
        expect(response.body).to include 'アカウント登録もしくはログインしてください。'
      end
    end
  end
end
