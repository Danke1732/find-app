require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    @profile = FactoryBot.build(:profile)
  end

  context 'profileの登録がうまくいくとき' do
    it '趣味、好きな言葉、自己紹介が全て入力されていれば登録できる' do
      expect(@profile).to be_valid
    end
    it 'hobbyがからでも登録できる' do
      @profile.hobby = nil
      expect(@profile).to be_valid
    end
    it 'favorite_wordがからでも登録できる' do
      @profile.favorite_word = nil
      expect(@profile).to be_valid
    end
    it 'introductionがからでも登録できる' do
      @profile.introduction = nil
      expect(@profile).to be_valid
    end
  end

  context 'profileの登録がうまくいかないとき' do
    it 'hobbyが140文字以上であれば登録できない' do
      @profile.hobby = '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901'
      @profile.valid?
      expect(@profile.errors.full_messages).to include("趣味は140文字以内で入力してください")
    end
    it 'favorite_wordが140文字以上であれば登録できない' do
      @profile.favorite_word = '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901'
      @profile.valid?
      expect(@profile.errors.full_messages).to include("好きな言葉は140文字以内で入力してください")
    end
  end
end
