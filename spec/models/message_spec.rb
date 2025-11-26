require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'メッセージの保存' do
    let(:message) { build(:message) }

    context '保存できる場合' do
      it '全ての値が揃っていれば保存できる' do
        expect(message).to be_valid
      end

      it 'read の初期値が false である' do
        message.save
        expect(message.read).to be(false)
      end
    end

    context '保存できない場合' do
      it 'content が空だと保存できない' do
        message.content = ''
        message.valid?
        expect(message.errors.full_messages).to include('メッセージを入力してください')
      end

      it 'user が紐づいていないと保存できない' do
        message.user = nil
        message.valid?
        expect(message.errors.full_messages).to include('ユーザーを入力してください')
      end

      it 'chat_room が紐づいていないと保存できない' do
        message.chat_room = nil
        message.valid?
        expect(message.errors.full_messages).to include('チャットルームを入力してください')
      end
    end
  end

  describe '.unread_for' do
    it '指定ユーザーが受信者として unread のものだけ取得できる' do
      chat_room = create(:chat_room)
      receiver = chat_room.receiver
      requester = chat_room.requester

      # receiver が受信した unread message
      msg1 = create(:message, chat_room: chat_room, user: requester, read: false)

      # receiver が送ったメッセージ（read 対象外）
      msg2 = create(:message, chat_room: chat_room, user: receiver, read: false)

      # 別 chat_room の unread（関係ない）
      other_room = create(:chat_room)
      msg3 = create(:message, chat_room: other_room, user: requester, read: false)

      result = Message.unread_for(receiver)

      expect(result).to include(msg1)
      expect(result).not_to include(msg2)
      expect(result).not_to include(msg3)
    end
  end
end
