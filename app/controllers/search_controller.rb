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
     @tweets = client.search(params[:search_terms]).take(50)
  end


  private
  
  def signed_in
    redirect_to root_url, notice: "Please sign in" unless current_user
  end
end
