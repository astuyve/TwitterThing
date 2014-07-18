module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

   $client = Twitter::REST::Client.new do |config|
    config.consumer_key = Figaro.env.twitter_api_key
    config.consumer_secret = Figaro.env.twitter_api_secret
  end 
end
