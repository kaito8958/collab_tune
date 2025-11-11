class ProductionSkill < ActiveHash::Base
  self.data = [
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
    { id: 11, name: 'Recデータ整音／エディット（Recording Support）' },
    { id: 12, name: 'Vocal Edit／Tuning' },
    { id: 13, name: '動画制作／アートワーク' },
    { id: 14, name: 'Other（その他）' }
  ]
end
