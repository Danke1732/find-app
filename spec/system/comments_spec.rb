require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user2.id)
    @comment_text = Faker::Lorem.characters(number: 50)
  end

  context 'コメント投稿ができるとき' do
    it 'ログインしているユーザーはコメントを投稿することができる' do
      # @userでログインする
      sign_in(@user)
      # @articleの記事詳細ページ移動する
      visit article_path(@article)
      # コメント投稿フォームの存在を確認
      expect(page).to have_selector('#comment_text')
      value = find('.comment-flag-icon')
      expect(value[:value]).to eq 'コメントする'
      # フォームへ内容を入力
      fill_in 'comment[text]', with: @comment_text
      # 送信するとコメント一覧BOXに投稿したコメントが表示される
      find('input[value="コメントする"]').click
      expect(find('#comments-indicate')).to have_content(@comment_text)
    end
  end
  context 'コメント投稿ができないとき' do
    it 'ログインしていないユーザーはコメントを投稿することができない' do
      # @userでログインする
      sign_in(@user)
      # @articleの記事詳細ページ移動する
      visit article_path(@article)
      # 「コメントする」ボタンがないことを確認する
      expect(page).to have_no_content('コメントする')
    end
  end
end

RSpec.describe 'コメント削除', type: :system, js: true do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @user3 = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user2.id)
    @comment = FactoryBot.create(:comment, user_id: @user.id, article_id: @article.id)
  end

  context 'コメント削除ができるとき' do
    it 'ログインしているコメントの投稿者は自分のコメントを削除することができる' do
      # @userでログインする
      sign_in(@user)
      # @articleの記事詳細ページへ移動する
      visit article_path(@article)
      # @commentが投稿されていて、削除ボタンがあるのを確認する
      expect(page).to have_content(@comment.text)
      expect(page).to have_selector('.comment-delete')
      # 削除ボタンを押して送信後、コメントが存在していないのを確認する
      sleep 3
      find('.comment-delete').click
      expect(page).to have_no_content(@comment.text)
    end
    it 'ログインしている記事の投稿者はコメントを削除することができる' do
      # @user2でログインする
      sign_in(@user2)
      # @articleの記事詳細ページへ移動する
      visit article_path(@article)
      # @commentが投稿されていて、削除ボタンがあるのを確認する
      expect(page).to have_content(@comment.text)
      expect(page).to have_selector('.comment-delete')
      # 削除ボタンを押して送信後、コメントが存在していないのを確認する
      sleep 3
      find('.comment-delete').click
      expect(page).to have_no_content(@comment.text)
    end
  end
  context 'コメント削除ができないとき' do
    it 'ログインしていないユーザーはコメントを削除することができない' do
      # トップページにいる
      visit root_path
      # @articleの記事詳細ページへ移動する
      visit article_path(@article)
      # @commentが投稿されているのを確認する
      expect(page).to have_content(@comment.text)
      # コメントに削除ボタンがないことを確認する
      expect(page).to have_no_selector('.comment-delete')
    end
    it 'ログインしているユーザーは自分以外のコメントを削除することができない' do
      # @user3でログインする
      sign_in(@user3)
      # @articleの記事詳細ページへ移動する
      visit article_path(@article)
      # @commentが投稿されていているのを確認する
      expect(page).to have_content(@comment.text)
      # コメントに削除ボタンがないことを確認する
      expect(page).to have_no_selector('.comment-delete')
    end
  end
end
