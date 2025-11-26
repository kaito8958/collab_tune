require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  let(:chat_room) { build(:chat_room) }

  describe 'チャットルームの保存' do
    context '保存できる場合' do
      it '必要な関連（requester, receiver, collaboration）が揃っていれば保存できる' do
        expect(chat_room).to be_valid
      end
    end

    context '保存できない場合' do
      it 'requester が紐づいていないと保存できない' do
        chat_room.requester = nil
        chat_room.valid?
        expect(chat_room.errors.full_messages).to include('申請者を入力してください')
      end

      it 'receiver が紐づいていないと保存できない' do
        chat_room.receiver = nil
        chat_room.valid?
        expect(chat_room.errors.full_messages).to include('受信者を入力してください')
      end

      it 'collaboration が紐づいていないと保存できない' do
        chat_room.collaboration = nil
        chat_room.valid?
        expect(chat_room.errors.full_messages).to include('コラボレーションを入力してください')
      end
    end
  end

  describe 'アソシエーション' do
    it { should belong_to(:requester).class_name('User') }
    it { should belong_to(:receiver).class_name('User') }
    it { should belong_to(:collaboration) }
    it { should have_many(:messages).dependent(:destroy) }
  end
end
