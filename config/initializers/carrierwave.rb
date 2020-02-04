# frozen_string_literal: true

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog'
    config.fog_credentials = {
      provider: 'AWS',
      region: ENV['ap-northeast-1'],
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY']
    }
    config.fog_directory = ENV['myacterstrage']
  end
end
