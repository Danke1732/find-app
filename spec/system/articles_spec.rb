require 'rails_helper'

RSpec.describe "記事投稿", type: :system do
  context '記事投稿ができるとき' do
    before do
      # article作成
      @user = FactoryBot.create(:user)
      @article_image = Rails.root.join('public/images/test-image.jpg')
      @article_title = Faker::Lorem.sentence
      @article_text = Faker::Lorem.sentence
      # カテゴリー選択
      work = Category.create(name: "仕事・仕事術")
      work_1 = work.children.create(name: "効率")
      work_1.children.create([{name: "ツール"},{name: "マインド"},{name: "その他"}])
      work_2 = work.children.create(name: "IT・メディア")
      work_2.children.create([{name: "通信"},{name: "IT"},{name: "ソフトウェア"},{name: "インターネット"},{name: "テレビ"},{name: "その他"}])
      work_3 = work.children.create(name: "時短術")
      work_3.children.create([{name: "道具"},{name: "考え方"},{name: "その他"}])

      licence = Category.create(name: "資格・検定")
      licence_1 = licence.children.create(name: "仕事")
      licence_1.children.create([{name: "マーケティング"},{name: "ビジネス"},{name: "その他"}])
      licence_2 = licence.children.create(name: "趣味")
      licence_2.children.create([{name: "料理"},{name: "ライフスタイル"},{name: "その他"}])
    end

    it 'ログインしたユーザーは新規投稿ができる', js: true do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 記事新規投稿ページへ移動する
      visit new_article_path
      # フォームに情報を入力する
      attach_file('article[image]', @article_image, make_visible: true)
      fill_in 'タイトル', with: @article_title
      fill_in '記事内容', with: @article_text
      find('select[id="category-select-box"]').click
      find('option', text: '仕事・仕事術').click
      find('select[id="category-select-box"]').click
      find('option', text: '---').click
      find('select[id="category-select-box"]').click
      find('option', text: '仕事・仕事術').click
      find('select[id="category-select-box2"]').click
      find('option', text: 'IT・メディア').click
      find('select[id="category-select-box2"]').click
      find('option', text: '効率').click
      find('select[id="category-select-box3"]').click
      find('option', text: 'ツール').click
      # 送信するとArticleモデルのカウントが1つ上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change{ Article.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する(投稿者名)
      expect(page).to have_content(@user.nickname)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する(タイトル)
      expect(page).to have_content(@article_title)
    end
  end
  context '記事投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがないのを確認
      expect(page).to have_no_content('投稿する')
    end
  end 
end

RSpec.describe '記事編集', type: :system do
  before do
    # user及びarticle作成
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user.id)
    @article2 = FactoryBot.create(:article, user_id: @user2.id)
    @article_image = Rails.root.join('public/images/test-image2.jpg')
    # カテゴリー選択
    work = Category.create(name: "仕事・仕事術")
    work_1 = work.children.create(name: "効率")
    work_1.children.create([{name: "ツール"},{name: "マインド"},{name: "その他"}])
    work_2 = work.children.create(name: "IT・メディア")
    work_2.children.create([{name: "通信"},{name: "IT"},{name: "ソフトウェア"},{name: "インターネット"},{name: "テレビ"},{name: "その他"}])
    work_3 = work.children.create(name: "時短術")
    work_3.children.create([{name: "道具"},{name: "考え方"},{name: "その他"}])

    health = Category.create(name: "健康")
    health_1 = health.children.create(name: "運動")
    health_1.children.create([{name: "ランニング"},{name: "ストレッチ"},{name: "その他"}])
    health_2 = health.children.create(name: "食生活")
    health_2.children.create([{name: "お肉"},{name: "野菜"},{name: "魚"},{name: "その他"}])
  end

  context '記事の編集ができるとき', js: true do
    it 'ログインしているユーザーは自分が投稿した記事を編集することができる' do
      # @userでログインする
      sign_in(@user)
      # @articleが存在する
      expect(page).to have_content(@article.title)
      expect(page).to have_content(@user.nickname)
      # @articleの投稿記事詳細画面へ移動する
      visit article_path(@article.id)
      # @userの投稿記事詳細画面に「編集」リンクが存在する
      expect(find(".article-details")).to have_link '編集', href: edit_article_path(@article)
      # @userの記事編集ページへ遷移する
      visit edit_article_path(@article.id)
      # 記事編集ページにはすでに投稿済みの内容がフォーム内に入っている
      expect(find("#title").value).to eq @article.title
      expect(find("#article-text").value).to eq @article.text
      # 投稿内容を編集する
      fill_in 'タイトル名', with: "#{@article.title} + 編集した記事タイトル"
      fill_in '記事内容', with: "#{@article.text} + 編集した記事テキスト"
      find('select[id="category-select-box"]').click
      find('option', text: '健康').click
      find('select[id="category-select-box"]').click
      find('option', text: '---').click
      find('select[id="category-select-box"]').click
      find('option', text: '健康').click
      find('select[id="category-select-box2"]').click
      find('option', text: '食生活').click
      find('select[id="category-select-box2"]').click
      find('option', text: '運動').click
      find('select[id="category-select-box3"]').click
      find('option', text: 'ランニング').click
      attach_file('article[image]', @article_image, make_visible: true)
      # 編集してもArticleモデルのカウントが変わらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change{ Article.count }.by(0)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページには先ほど変更した内容の記事が存在することを確認する(タイトル)
      expect(page).to have_content("#{@article.title} + 編集した記事タイトル")
      # トップページには先ほど変更した内容の記事が存在することを確認する(投稿者)
      expect(page).to have_content(@user.nickname)
    end
  end
  context '記事の編集ができないとき' do
    it 'ログインしたユーザーは自分以外の記事の投稿を編集することはできないこと' do
      # @userでログインする
      sign_in(@user)
      # @article2(投稿者は@user2)が存在している
      expect(page).to have_content(@article2.title)
      expect(page).to have_content(@user2.nickname)
      # @article2(投稿者は@user2)の投稿記事詳細画面へ移動する
      visit article_path(@article2.id)
      # @userの投稿記事詳細画面に「編集」リンクが存在しないことを確認する
      expect(".article-details").to have_no_link '編集', href: edit_article_path(@article2.id)
    end
    it 'ログインしていないと記事を編集することができないこと' do
      # トップページにいる
      visit root_path
      # @articleの記事詳細画面へ移動する
      visit article_path(@article.id)
      # @articleに「編集」リンクがないことを確認する
      expect(find(".article-details")).to have_no_link '編集', href: edit_article_path(@article.id)
      # トップページに移動する
      visit root_path
      # @article2の記事詳細画面へ移動する
      visit article_path(@article2.id)
      # @article2に「編集」リンクがないことを確認する
      expect(find(".article-details")).to have_no_link '編集', href: edit_article_path(@article2.id)
    end
  end
end

RSpec.describe '記事削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user.id)
    @article2 = FactoryBot.create(:article, user_id: @user2.id)
  end

  context '記事の削除ができるとき' do
    it 'ログインしているユーザーは自分が投稿している記事を削除することができる' do
      # @userでログインする
      sign_in(@user)
      # @articleが存在する
      expect(page).to have_content(@article.title)
      expect(page).to have_content(@user.nickname)
      # @articleの投稿記事詳細画面へ移動する
      visit article_path(@article)
      # @userの投稿記事詳細画面に「削除」リンクが存在する
      expect(find(".article-details")).to have_link '削除', href: article_path(@article)
      # 記事を削除するとArticleモデルのカウントが1下がるのを確認する
      expect {
        find_link('削除', href: article_path(@article)).click
      }.to change{ Article.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページに先ほど削除した記事がないことを確認する(タイトル)
      expect(page).to have_no_content(@article.title)
    end
  end
  context '記事の削除ができないとき' do
    it 'ログインしているユーザーで自分以外が投稿している記事を削除することはできない' do
      # @userでログインする
      sign_in(@user)
      # @article2が存在する
      expect(page).to have_content(@article2.title)
      expect(page).to have_content(@user2.nickname)
      # @article2の投稿記事詳細画面へ移動する
      visit article_path(@article2)
      # @userの投稿記事詳細画面に「削除」リンクが存在しないことを確認する
      expect(page).to have_no_link '削除', href: article_path(@article2)
    end
    it 'ログインしていないと記事を削除することができない' do
      # トップページにいる
      visit root_path
      # @articleの記事詳細画面へ移動する
      visit article_path(@article)
      # @articleの記事詳細画面に「削除」リンクがないことを確認する
      expect(page).to have_no_link '削除', href: article_path(@article)
      # トップページに移動する
      visit root_path
      # @article2の記事詳細画面へ移動する
      visit article_path(@article2)
      # @article2の記事詳細画面に「削除」リンクがないことを確認する
      expect(page).to have_no_link '削除', href: article_path(@article2)
    end
  end
end

RSpec.describe '記事詳細', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user2.id)
  end
  context 'ログインしているとき' do
    it 'ログインしているユーザーは記事詳細ページに遷移すると「コメントする」ボタンが表示される' do
      # @userでログインする
      sign_in(@user)
      # @articleが存在する
      expect(page).to have_content(@article.title)
      expect(page).to have_content(@user.nickname)
      # @articleの記事詳細ページへ移動する
      visit article_path(@article)
      # @articleの記事詳細ページに「コメントする」のsubmitボタンが存在するのを確認する
      value = find('.comment-flag-icon')
      expect(value[:value]).to eq "コメントする"
    end
    it 'ログインしているユーザーで自分が投稿した記事以外の記事詳細ページに遷移すると「ブックマーク登録をする」ボタンが表示される' do
      # @userでログインする
      sign_in(@user)
      # @articleが存在する
      expect(page).to have_content(@article.title)
      expect(page).to have_content(@user.nickname)
      # @articleの記事詳細ページへ移動する
      visit article_path(@article)
      # @articleの記事詳細ページに「ブックマーク登録をする」ボタンが存在するのを確認する
      expect(page).to have_content('ブックマーク登録をする')
    end
  end
  context 'ログインしていないとき' do
    it 'ログインしていない状態で記事詳細ページに遷移することはできるものの「新規登録」リンク、「ログイン」リンクが表示される' do
      # トップページにいる
      visit root_path
      # @articleが存在する
      expect(page).to have_content(@article.title)
      expect(page).to have_content(@user2.nickname)
      # @articleの記事詳細ページへ移動する
      visit article_path(@article.id)
      # @articleの記事詳細ページに「コメントする」のsubmitボタンが存在しないのを確認する
      expect(find('.comment-signup')).to have_content('新規登録')
      expect(find('.comment-signin')).to have_content('ログイン')
    end
    it 'ログインしていない状態で記事詳細ページに遷移することはできるものの「ブックマーク登録をする」ボタンが表示されない' do
      # トップページにいる
      visit root_path
      # @articleが存在する
      expect(page).to have_content(@article.title)
      expect(page).to have_content(@user2.nickname)
      # @articleの記事詳細ページへ移動する
      visit article_path(@article.id)
      # @articleの記事詳細ページに「ブックマーク登録をする」ボタンが存在するのを確認する
      expect(page).to have_no_content('ブックマーク登録をする')
    end
  end
end

RSpec.describe '記事検索', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user_id: @user.id)
    @article2 = FactoryBot.create(:article, user_id: @user2.id)
  end

  it '検索欄から記事タイトルに合致する項目があれば検索結果に表示される' do
    # トップページにいる
    visit root_path
    # 記事タイトルから検索する
    fill_in 'keyword', with: @article.title
    find('.search-btn').click
    # 検索結果ページに遷移する
    expect(current_path).to eq search_articles_path
    # 検索欄に入力した記事タイトルが表示される
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@user.nickname)
  end
  it '検索欄から記事本文に合致する項目があれば検索結果に表示される' do
    # トップページにいる
    visit root_path
    # 記事タイトルから検索する
    fill_in 'keyword', with: @article.text
    find('.search-btn').click
    # 検索結果ページに遷移する
    expect(current_path).to eq search_articles_path
    # 検索欄に入力した記事タイトルが表示される
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@user.nickname)
  end
end
