class Image < ApplicationRecord
  belongs_to :item
  mount_uploader :imge, ImageUploader
end
