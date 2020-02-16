class Delivery_days < ActiveHash::Base
  self.data = [
    { id: 1, day: '1~2日で発送' },
    { id: 2, day: '2~3日で発送' },
    { id: 3, day: '4~7日で発送' }
  ]
end