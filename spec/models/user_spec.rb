require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    let(:user) { build(:user) }

    context '登録できる場合' do
      it '全ての値が存在すれば登録できる' do
        expect(user).to be_valid
      end
    end

    context '登録できない場合' do
      it 'nicknameが空では登録できない' do
        user.nickname = ''
        user.valid?
        expect(user.errors.full_messages).to include('ニックネームを入力してください')
      end

      it 'emailが空では登録できない' do
        user.email = ''
        user.valid?
        expect(user.errors.full_messages).to include('メールアドレスを入力してください')
      end

      it 'passwordが空では登録できない' do
        user.password = ''
        user.password_confirmation = ''
        user.valid?
        expect(user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'passwordが英字のみでは登録できない' do
        user.password = 'abcdef'
        user.password_confirmation = 'abcdef'
        user.valid?
        expect(user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordが数字のみでは登録できない' do
        user.password = '123456'
        user.password_confirmation = '123456'
        user.valid?
        expect(user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordが6文字未満では登録できない' do
        user.password = 'a1b2'
        user.password_confirmation = 'a1b2'
        user.valid?
        expect(user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it '重複したemailは登録できない' do
        create(:user, email: 'test@example.com')
        user.email = 'test@example.com'
        user.valid?
        expect(user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
    end
  end
end
