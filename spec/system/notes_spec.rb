require 'rails_helper'

RSpec.describe 'メモ保存', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user.id)
    @note = Faker::Lorem.sentence
  end

  context 'メモを保存することができるとき', js: true do
    it 'ログインしているユーザーであれば保存することができる(root_path時)' do
      # @userでログインする
      sign_in(@user)
      # メモ投稿フォームの確認 → フォームに内容を入力する → 送信後、Noteモデルのカウント1上がる → 送信後フォーム入力内容がないことの確認
      note_submit
    end
    it 'ログインしているユーザーであれば保存することができる(article_path(@article)時)' do
      # @userでログインする
      sign_in(@user)
      # 記事詳細ページへ移動する
      visit article_path(@article)
      # メモ投稿フォームの確認 → フォームに内容を入力する → 送信後、Noteモデルのカウント1上がる → 送信後フォーム入力内容がないことの確認
      note_submit
    end
    it 'ログインしているユーザーであれば保存することができる(search_articles_path時)' do
      # @userでログインする
      sign_in(@user)
      # 記事検索結果ページへ移動する
      fill_in 'keyword', with: @article.title
      find('.search-btn').click
      expect(current_path).to eq search_articles_path
      # メモ投稿フォームの確認 → フォームに内容を入力する → 送信後、Noteモデルのカウント1上がる → 送信後フォーム入力内容がないことの確認
      note_submit
    end
    it 'ログインしているユーザーであれば保存することができる(user_bookmarks_path(@user)時)' do
      # @userでログインする
      sign_in(@user)
      # @userのブックマーク記事一覧ページへ移動する
      visit user_bookmarks_path(@user)
      # メモ投稿フォームの確認 → フォームに内容を入力する → 送信後、Noteモデルのカウント1上がる → 送信後フォーム入力内容がないことの確認
      note_submit
    end
    it 'ログインしているユーザーであれば保存することができる(user_notes_path(@user)時)' do
      # @userでログインする
      sign_in(@user)
      # @userのメモ一覧ページへ移動する
      visit user_notes_path(@user)
      # メモ投稿フォームの確認 → フォームに内容を入力する → 送信後、Noteモデルのカウント1上がる → 送信後フォーム入力内容がないことの確認
      note_submit
      # 送信した内容のメモがメモ一覧ページに表示されている
      expect(page).to have_content(@note)
    end
    it 'ログインしているユーザーであれば保存することができる(user_profiles_path(@user)時)' do
      # @userでログインする
      sign_in(@user)
      # @userのプロフィール一覧ページへ移動する
      visit user_profiles_path(@user)
      # メモ投稿フォームの確認 → フォームに内容を入力する → 送信後、Noteモデルのカウント1上がる → 送信後フォーム入力内容がないことの確認
      note_submit
    end
    it 'ログインしているユーザーであれば保存することができる(users_path時)' do
      # @userでログインする
      sign_in(@user)
      # ユーザー一覧ページへ移動する
      visit users_path
      # メモ投稿フォームの確認 → フォームに内容を入力する → 送信後、Noteモデルのカウント1上がる → 送信後フォーム入力内容がないことの確認
      note_submit
    end
    it 'ログインしているユーザーであれば保存することができる(user_path(@user)時)' do
      # @userでログインする
      sign_in(@user)
      # ユーザー一覧ページへ移動する
      visit user_path(@user)
      # メモ投稿フォームの確認 → フォームに内容を入力する → 送信後、Noteモデルのカウント1上がる → 送信後フォーム入力内容がないことの確認
      note_submit
    end
  end
  context 'メモを保存することができないとき' do
    it 'ログインしていないユーザーはメモを保存することができない' do
      # トップページにいる
      visit root_path
      # メモ記述フォームがないことを確認する
      expect(page).to have_no_selector('.memo-form')
    end
  end
end

RSpec.describe 'メモ削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user.id)
    @note = FactoryBot.create(:note, user_id: @user.id)
  end

  context 'メモを削除できるとき' do
    it 'ログインしているユーザーであれば自身のメモ一覧ページのメモを削除することができる' do
      # @userでログインする
      sign_in(@user)
      # メモ一覧ページへ遷移するリンクがある
      expect(page).to have_link 'ノート', href: user_notes_path(@user)
      # @userのメモ一覧ページに遷移する
      click_on 'ノート'
      # @userの投稿しているメモが表示されている
      expect(page).to have_content(@note.text)
      # メモの削除ボタンを押すと、メモのカウントが1下がる
      sleep 1
      expect do
        find('.note-delete').click
        sleep 1
      end.to change { Note.count }.by(-1)
      # メモ一覧ページから保存していたメモが存在していないのを確認する
      expect(page).to have_no_content(@note.text)
    end
  end
  context 'メモを削除できないとき' do
    it 'ログインしていないユーザーはメモ一覧ページに遷移することができない' do
      # メモ一覧ページへ遷移するリンクが存在しない
      expect(page).to have_no_link 'ノート', href: user_notes_path(@user)
    end
  end
end
