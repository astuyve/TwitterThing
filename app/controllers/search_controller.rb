class SearchController < ApplicationController
  include ApplicationHelper
  before_filter :signed_in, only: [:tweets]

  def index
  end

  def tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Figaro.env.twitter_api_key
      config.consumer_secret = Figaro.env.twitter_api_secret
    end
    @search_terms = params[:search_terms]
    @tweets = client.search(params[:search_terms]).take(50)
  end

  def timeline
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Figaro.env.twitter_api_key
      config.consumer_secret = Figaro.env.twitter_api_secret
    end
    @twitter_user = params[:twitter_user]
    @tweets = client.user_timeline(params[:twitter_user])
  end


  private
  
  def signed_in
    redirect_to root_url, notice: "Please sign in" unless current_user
  end
end
