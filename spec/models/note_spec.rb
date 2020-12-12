require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @note = FactoryBot.build(:note)
  end
  describe 'メモ機能' do
    context 'メモ投稿がうまくいくとき' do
      it 'テキストが入力されていれば保存できる' do
        expect(@note).to be_valid
      end
    end

    context 'メモ投稿がうまくいかないとき' do
      it 'テキストが空だと保存できない' do
        @note.text = nil
        @note.valid?
        expect(@note.errors.full_messages).to include('ノートを入力してください')
      end
    end
  end
end
