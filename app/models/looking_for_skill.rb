class LookingForSkill < ActiveHash::Base
  self.data = [
    # 制作系スキル（トラックメイカー／プロデューサー募集など）
    { id: 1, name: '作曲（Composition）' },
    { id: 2, name: '作詞（Lyrics）' },
    { id: 3, name: '編曲（Arrangement）' },
    { id: 4, name: 'ビートメイク（Beatmaking）' },
    { id: 5, name: 'トラックメイク（Trackmaking）' },
    { id: 6, name: '打ち込みのブラッシュアップ（Drum／Programming）' },
    { id: 7, name: 'サウンドデザイン（Synth／音作り）' },
    { id: 8, name: 'オーケストレーション' },
    { id: 9, name: 'ミックス（Mixing）' },
    { id: 10, name: 'マスタリング（Mastering）' },

    # 演奏・表現系
    { id: 11, name: 'Vocal（ボーカル）' },
    { id: 12, name: 'Rap／MC' },
    { id: 13, name: 'Guitar（ギター）' },
    { id: 14, name: 'Bass（ベース）' },
    { id: 15, name: 'Drums（ドラム）' },
    { id: 16, name: 'Keyboard／Piano（鍵盤）' },
    { id: 17, name: 'Strings／Brass（ストリングス／ホーン）' },
    { id: 18, name: 'Chorus／Harmony（コーラス）' },

    # その他
    { id: 19, name: 'Recデータ整音／エディット（Recording Support）' },
    { id: 20, name: 'Vocal Edit／Tuning' },
    { id: 21, name: '動画制作／アートワーク' },
    { id: 22, name: 'Other（その他）' }
  ]
end
