require 'rails_helper'

RSpec.describe "プロフィール登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @profile_hobby = Faker::Lorem.sentence
    @profile_favorite_word = Faker::Lorem.sentence
    @profile_introduction = Faker::Lorem.sentence
  end

  context 'プロフィール投稿ができるとき' do
    it 'ログインしているユーザーはプロフィールを作成することができる' do
      # @userでログインする
      sign_in(@user)
      # プロフィール一覧ページへの遷移リンクが存在することを確認する
      expect(find('.user_sign_in')).to have_link "#{@user.nickname}", href: user_profiles_path(@user)
      # プロフィール一覧ページへ移動する
      find('.user_name').click
      # プロフィール新規作成ページへの遷移リンクが存在することを確認する
      expect(page).to have_link "プロフィールを作成する", href: new_profile_path
      # プロフィール新規作成ページへ移動する
      click_on 'プロフィールを作成する'
      # フォームに情報を入力する
      fill_in 'profile[hobby]', with: @profile_hobby
      fill_in 'profile[favorite_word]', with: @profile_favorite_word
      fill_in 'profile[introduction]', with: @profile_introduction
      # 送信するとProfileモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change{ Profile.count }.by(1)
      # プロフィール一覧画面に遷移する
      expect(current_path).to eq user_profiles_path(@user)
      # プロフィール一覧画面には先ほど入力したプロフィール内容が存在する(趣味)
      expect(page).to have_content(@profile_hobby)
      # プロフィール一覧画面には先ほど入力したプロフィール内容が存在する(好きな言葉)
      expect(page).to have_content(@profile_favorite_word)
      # プロフィール一覧画面には先ほど入力したプロフィール内容が存在する(自己紹介)
      expect(page).to have_content(@profile_introduction)
    end
  end

  context 'プロフィール投稿ができないとき' do
    it 'ログインしていないユーザーはプロフィール一覧遷移リンクがない' do
      # トップページにいる
      visit root_path
      # プロフィール一覧の遷移リンクが存在しないことを確認する
      expect(page).to have_no_link "#{@user.nickname}", href: user_profiles_path(@user)
    end
  end
end

RSpec.describe 'プロフィール編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @profile = FactoryBot.create(:profile, user_id: @user.id)
    @profile_hobby = Faker::Lorem.sentence
    @profile_favorite_word = Faker::Lorem.sentence
    @profile_introduction = Faker::Lorem.sentence
  end

  context 'プロフィール編集ができるとき' do
    it 'ログインしているユーザーはプロフィールを編集することができる' do
      # @userでログインする
      sign_in(@user)
      # プロフィール一覧ページへの遷移リンクが存在することを確認する
      expect(find('.user_sign_in')).to have_link "#{@user.nickname}", href: user_profiles_path(@user)
      # プロフィール一覧ページへ移動する
      find('.user_name').click
      # プロフィール新規作成ページへの遷移リンクが存在することを確認する
      expect(page).to have_link "プロフィールを編集する", href: user_profiles_edit_path(@user)
      # プロフィール新規作成ページへ移動する
      click_on 'プロフィールを編集する'
      # フォームにはすでに作成済みのプロフィール内容がフォーム内に入っている
      expect(find('#hobby').value).to eq @profile.hobby
      expect(find('#favorite_word').value).to eq @profile.favorite_word
      expect(find('#introduction').value).to eq @profile.introduction
      # フォームに情報を入力する
      fill_in 'profile[hobby]', with: @profile_hobby
      fill_in 'profile[favorite_word]', with: @profile_favorite_word
      fill_in 'profile[introduction]', with: @profile_introduction
      # 送信するとProfileモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change{ Profile.count }.by(0)
      # プロフィール一覧画面に遷移する
      expect(current_path).to eq user_profiles_path(@user)
      # プロフィール一覧画面には先ほど入力したプロフィール内容が存在する(趣味)
      expect(page).to have_content(@profile_hobby)
      # プロフィール一覧画面には先ほど入力したプロフィール内容が存在する(好きな言葉)
      expect(page).to have_content(@profile_favorite_word)
      # プロフィール一覧画面には先ほど入力したプロフィール内容が存在する(自己紹介)
      expect(page).to have_content(@profile_introduction)
    end
  end
  context 'プロフィール編集ができないとき' do
    it 'ログインしていないユーザーはプロフィール一覧遷移リンクがない' do
      # トップページにいる
      visit root_path
      # プロフィール一覧の遷移リンクが存在しないことを確認する
      expect(page).to have_no_link "#{@user.nickname}", href: user_profiles_path(@user)
    end
  end
end
