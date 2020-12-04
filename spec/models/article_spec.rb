require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = FactoryBot.build(:article)
  end

  describe '記事投稿機能' do
    context '記事投稿がうまくいくとき' do
      it 'image,title,text,categoryを全て入力されていれば投稿することができる' do
        expect(@article).to be_valid
      end
    end

    context '記事投稿がうまくいかないとき' do
      it 'titleが空だと投稿することができない' do
        @article.title = nil
        @article.valid?
        expect(@article.errors.full_messages).to include("Title can't be blank")
      end
      it 'imageが空だと投稿することができない' do
        @article.image = nil
        @article.valid?
        expect(@article.errors.full_messages).to include("Image can't be blank")
      end
      it 'textが空だと投稿することができない' do
        @article.text = nil
        @article.valid?
        expect(@article.errors.full_messages).to include("Text can't be blank")
      end
      it 'category_idがcategoryに紐づいたデータでないと投稿することができない' do
        @article.category = nil
        @article.valid?
        expect(@article.errors.full_messages).to include('Category must exist')
      end
      it 'userが紐づいていないと投稿することができない' do
        @article.user = nil
        @article.valid?
        expect(@article.errors.full_messages).to include('User must exist')
      end
    end
  end
end
