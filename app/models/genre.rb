class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: 'Pop' },
    { id: 2, name: 'Rock' },
    { id: 3, name: 'EDM' },
    { id: 4, name: 'R&B / Soul' },
    { id: 5, name: 'Hip Hop' },
    { id: 6, name: 'Electronic' },
    { id: 7, name: 'Jazz / Fusion' },
    { id: 8, name: 'City Pop' },
    { id: 9, name: 'Lo-fi / Chill' },
    { id: 10, name: 'Funk / Disco' },
    { id: 11, name: 'Classical' },
    { id: 12, name: 'Soundtrack / Game' },
    { id: 13, name: 'Other(その他)' }
  ]
end
