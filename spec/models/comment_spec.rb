require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメントの保存' do
    let(:comment) { build(:comment) }

    context '保存できる場合' do
      it '全ての値が存在すれば保存できる' do
        expect(comment).to be_valid
      end
    end

    context '保存できない場合' do
      it 'body が空だと保存できない' do
        comment.body = ''
        comment.valid?
        expect(comment.errors.full_messages).to include('コメントを入力してください')
      end

      it 'user が紐づいていないと保存できない' do
        comment.user = nil
        comment.valid?
        expect(comment.errors.full_messages).to include('ユーザーを入力してください')
      end

      it 'post が紐づいていないと保存できない' do
        comment.post = nil
        comment.valid?
        expect(comment.errors.full_messages).to include('投稿を入力してください')
      end
    end
  end
end
