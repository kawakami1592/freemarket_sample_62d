class Boughtflg < ActiveHash::Base
  self.data = [
    { id: 1, boughtflg: '出品中' },
    { id: 2, boughtflg: '完売' }
  ]
end
