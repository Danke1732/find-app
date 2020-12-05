require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿機能' do
    context 'コメント投稿がうまくいくとき' do
      it 'textを入力しているとき' do
        expect(@comment).to be_valid
      end
    end

    context 'コメント投稿がうまくいかないとき' do
      it 'textが空のときは投稿ができない' do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Text translation missing: ja.activerecord.errors.models.comment.attributes.text.blank')
      end
    end
  end
end
