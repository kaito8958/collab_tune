require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '投稿の保存' do
    let(:post) { build(:post) }

    context '保存できる場合' do
      it '必要な情報が揃っていれば保存できる（closed）' do
        expect(post).to be_valid
      end

      it 'recruiting の場合、必要な項目が揃っていれば保存できる' do
        post = build(:post, :recruiting)
        expect(post).to be_valid
      end
    end

    context '保存できない場合' do
      it 'タイトルが空では保存できない' do
        post.title = ''
        post.valid?
        expect(post.errors.full_messages).to include('タイトルを入力してください')
      end

      it '募集状況が空では保存できない' do
        post.status = nil
        post.valid?
        expect(post.errors.full_messages).to include('募集状況を入力してください')
      end

      it 'ユーザーが紐づいていないと保存できない' do
        post.user = nil
        post.valid?
        expect(post.errors.full_messages).to include('ユーザーを入力してください')
      end

      it 'recruiting の場合、募集パートが空だと保存できない' do
        post = build(:post, :recruiting, looking_for_skill_ids: [])
        post.valid?
        expect(post.errors.full_messages).to include('募集パートを1つ以上選んでください')
      end

      it 'recruiting の場合、募集の詳細が空だと保存できない' do
        post = build(:post, :recruiting, recruiting_details: '')
        post.valid?
        expect(post.errors.full_messages).to include('募集の詳細を入力してください')
      end
    end
  end
end
