# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
  { image_size: 'bigger', authorize_params: { lang: 'ja' } }
end
