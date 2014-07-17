class SearchController < ApplicationController
  include ApplicationHelper
  before_filter :signed_in, only: [:tweets, :timeline]

  def index
  end

  def tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Figaro.env.twitter_api_key
      config.consumer_secret = Figaro.env.twitter_api_secret
    end
    @search_terms = params[:search_terms]
    @tweets = client.search(params[:search_terms]).take(100)
  end

  def timeline
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Figaro.env.twitter_api_key
      config.consumer_secret = Figaro.env.twitter_api_secret
    end
    @twitter_user = params[:twitter_user]
    @tweets = client.user_timeline(@twitter_user, :count => "100")
    @loc = []
    @tweets.each do |tweet|
      if tweet.geo.coordinates.present?
        formatted_geo = "#{tweet.geo.coordinates[0]},#{tweet.geo.coordinates[1]},#{tweet.text}"
        @loc.push(formatted_geo)
      end
    end
  end


  private
  
  def signed_in
    redirect_to root_url, notice: "Please sign in" unless current_user
  end
end
