FactoryBot.define do
  factory :blob, class: ActiveStorage::Blob do
    sequence(:key) { SecureRandom.urlsafe_base64 }  # ユニークなキーでなければならない
    filename {'Unknown.jpeg'}
    content_type {'image/jpeg'}
    metadata {'{"identified":true,"width":295,"height":171,"analyzed":true}'}
    byte_size {'3786'}
    checksum {'I03rQYVs3TMUHgFlq0Gx1g=='}

    after(:create) do |blob|
      path = blob.service.send(:path_for, blob.key)
      FileUtils.mkdir_p(File.dirname(path))
      FileUtils.copy_file("#{Rails.root}/spec/images/Unknown.jpeg", path) # テストファイル image.png をファイルアップロード後の場所に移動する
    end
  end
end