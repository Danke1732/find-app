require 'rails_helper'

RSpec.describe 'Bookmarks', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user2.id)
  end

  context 'ブックマーク登録ができるとき' do
    it 'ログインしているユーザーで記事投稿者以外であればブックマーク登録ができる' do
      # @userでログインする
      sign_in(@user)
      # @articleの記事詳細ページ移動する
      visit article_path(@article)
      # 「ブックマーク登録をする」ボタンの存在を確認する
      expect(page).to have_content('ブックマーク登録をする')
      # 送信すると「ブックマーク登録を外す」に表示が変わることを確認する
      sleep 1
      find('.bookmarks-btn').click
      expect(page).to have_content('ブックマーク登録を外す')
    end
  end

  context 'ブックマーク登録ができないとき' do
    it 'ログインしていないユーザーはブックマーク登録ができない' do
      # @userでログインする
      sign_in(@user)
      # @articleの記事詳細ページ移動する
      visit article_path(@article)
      # 「ブックマーク登録をする」ボタンの存在しないのを確認する
      expect(page).to have_no_link 'ブックマーク登録をする'
    end
    it 'ログインしているユーザーで自分の投稿した記事はブックマーク登録ができない' do
      # @user2でログインする
      sign_in @user
      # @articleの記事詳細ページ移動する
      visit article_path(@article)
      # 「ブックマーク登録をする」ボタンの存在しないのを確認する
      expect(page).to have_no_link 'ブックマーク登録をする'
    end
  end
end
