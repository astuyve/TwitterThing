require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key = Figaro.env.twitter_api_key
  config.consumer_secret = Figaro.env.twitter_api_secret
end
