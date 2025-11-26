require 'rails_helper'

RSpec.describe Collaboration, type: :model do
  describe 'コラボ申請の保存' do
    let(:collaboration) { build(:collaboration) }

    context '保存できる場合' do
      it '全ての値が存在すれば保存できる' do
        expect(collaboration).to be_valid
      end
    end

    context '保存できない場合' do
      it 'message が空だと保存できない' do
        collaboration.message = ''
        collaboration.valid?
        expect(collaboration.errors.full_messages).to include('メッセージを入力してください')
      end

      it 'status が許可されていない値だと保存できない' do
        collaboration.status = 'unknown'
        collaboration.valid?
        expect(collaboration.errors.full_messages).to include('状況は一覧にありません')
      end

      it '同じ requester / receiver / post の組み合わせでは重複して申請できない' do
        existing = create(:collaboration)
        dup = build(
          :collaboration,
          requester: existing.requester,
          receiver: existing.receiver,
          post: existing.post
        )

        dup.valid?
        # モデルで書いた日本語メッセージをそのまま検証
        expect(dup.errors.full_messages).to include('申請者はすでにこの投稿に申請しています')
      end

      it 'requester が nil だと保存できない' do
        collaboration.requester = nil
        collaboration.valid?
        expect(collaboration.errors.full_messages).to include('申請者を入力してください')
      end

      it 'receiver が nil だと保存できない' do
        collaboration.receiver = nil
        collaboration.valid?
        expect(collaboration.errors.full_messages).to include('受信者を入力してください')
      end

      it 'post が nil だと保存できない' do
        collaboration.post = nil
        collaboration.valid?
        expect(collaboration.errors.full_messages).to include('投稿を入力してください')
      end
    end
  end
end
