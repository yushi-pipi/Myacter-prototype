# frozen_string_literal: true

require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog'
    config.fog_credentials = {
      provider: 'AWS',
      region: ENV['ap-northeast-1'],
      aws_access_key_id: ENV['AKIA3EX5LE5GWXEGG4FP'],
      aws_secret_access_key: ENV['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'],
      path_style: true
    }
    config.fog_directory = ENV['myacterstrage']
    config.cache_storage = :fog
  end
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
end
