# require 'carrierwave/storage/abstract'
# require 'carrierwave/storage/file'
# require 'carrierwave/storage/fog'

# CarrierWave.configure do |config|
#   if Rails.env.production? # 本番環境:AWS使用
#     config.storage = :fog
#     config.fog_provider = 'fog/aws'
#     config.fog_credentials = {
#       provider: 'AWS',
#       aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
#       aws_secret_access_key: Rails.application.credentials.aws[:access_key_id],
#       secret_key_base: Rails.application.credentials.secret_key_base,
#       region: 'ap-northeast-1'
#     }
#     config.fog_directory  = 'freemarket-sample-62d'
#     config.fog_host = 'https://s3-ap-northeast-1.amazonaws.com/freemarket-sample-62d'
#   else
#     config.storage :file # 開発環境:public/uploades下に保存
#     config.enable_processing = false if Rails.env.test? #test:処理をスキップ
#   end
# end