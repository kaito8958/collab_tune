class Daw < ActiveHash::Base
  self.data = [
    { id: 1, name: 'Ableton Live' },
    { id: 2, name: 'Logic Pro' },
    { id: 3, name: 'Cubase' },
    { id: 4, name: 'Studio One' },
    { id: 5, name: 'FL Studio' },
    { id: 6, name: 'Pro Tools' },
    { id: 7, name: 'GarageBand' },
    { id: 8, name: 'Bitwig Studio' },
    { id: 9, name: 'Reason' },
    { id: 10, name: 'その他（Other）' }
  ]
end
