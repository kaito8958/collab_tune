class LookingForSkill < ActiveHash::Base
  self.data = [
    # 制作系スキル（トラックメイカー／プロデューサー募集など）
    { id: 1, name: '作曲' },
    { id: 2, name: '作詞' },
    { id: 3, name: '編曲' },
    { id: 4, name: 'ビートメイク' },
    { id: 5, name: 'トラックメイク' },
    { id: 6, name: '打ち込みのブラッシュアップ' },
    { id: 7, name: 'サウンドデザイン（Synth/音作り）' },
    { id: 8, name: 'オーケストレーション' },
    { id: 9, name: 'Mix' },
    { id: 10, name: 'Mastering' },

    # 演奏・表現系
    { id: 11, name: 'Vocal' },
    { id: 12, name: 'Rap/MC' },
    { id: 13, name: 'Guitar' },
    { id: 14, name: 'Bass' },
    { id: 15, name: 'Drums' },
    { id: 16, name: 'Keyboard/Piano' },
    { id: 17, name: 'Strings/Brass' },
    { id: 18, name: 'Chorus' },

    # その他
    { id: 19, name: 'Recデータ整音/エディット）' },
    { id: 20, name: 'ピッチ補正' },
    { id: 21, name: '動画制作/アートワーク' },
    { id: 22, name: 'Other（その他）' }
  ]
end
