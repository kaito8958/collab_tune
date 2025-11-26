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
  describe '音源ファイルのバリデーション' do
    it 'MP3ファイルなら保存できる' do
      post = build(:post)
      file = Rack::Test::UploadedFile.new(
        Rails.root.join('spec/fixtures/files/mp3_dummy.mp3'),
        'audio/mpeg'
      )
      post.audio.attach(file)
      expect(post).to be_valid
    end

    it 'MP3以外のファイルだと保存できない' do
      post = build(:post)
      file = Rack::Test::UploadedFile.new(
        Rails.root.join('spec/fixtures/files/text_dummy.txt'),
        'text/plain'
      )
      post.audio.attach(file)
      post.valid?
      expect(post.errors.full_messages).to include('音源はMP3形式のファイルをアップロードしてください')
    end
  end
  describe '境界値のテスト' do
    let(:post) { build(:post, :recruiting) }

    context 'タイトルの文字数' do
      it '35文字なら保存できる' do
        post.title = 'あ' * 35
        expect(post).to be_valid
      end

      it '36文字だと保存できない' do
        post.title = 'あ' * 36
        post.valid?
        expect(post.errors.full_messages).to include('タイトルは35文字以内で入力してください')
      end
    end

    context 'テンポの数値' do
      it '30なら保存できる' do
        post.tempo = 30
        expect(post).to be_valid
      end

      it '300なら保存できる' do
        post.tempo = 300
        expect(post).to be_valid
      end

      it '29だと保存できない' do
        post.tempo = 29
        post.valid?
        expect(post.errors.full_messages).to include('テンポ（BPM）は30以上の値にしてください')
      end

      it '301だと保存できない' do
        post.tempo = 301
        post.valid?
        expect(post.errors.full_messages).to include('テンポ（BPM）は300以下の値にしてください')
      end

      it '整数以外だと保存できない' do
        post.tempo = 120.5
        post.valid?
        expect(post.errors.full_messages).to include('テンポ（BPM）は整数で入力してください')
      end
    end
  end
end
