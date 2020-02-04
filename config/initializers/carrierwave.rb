# frozen_string_literal: true

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      region: ENV['ap-northeast-1'],
      aws_access_key_id: ENV['SAKIA3EX5LE5GWXEGG4FP'],
      aws_secret_access_key: ENV['28wyx8MK+NHzl4P4OAxnZrnBq1Ng4N6VOcC9+8bU']
    }
    config.fog_directory = ENV['myacterstrage']
  end
end
