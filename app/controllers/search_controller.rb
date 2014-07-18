class SearchController < ApplicationController
  include ApplicationHelper
  before_filter :signed_in, only: [:tweets, :timeline]

  def index
  end

  def tweets
    @search_terms = params[:search_terms]
    @tweets = $client.search(params[:search_terms]).take(100)
  end

  def timeline
    @twitter_user = params[:twitter_user]
    @tweets = $client.user_timeline(@twitter_user, :count => "100")
    @city = $client.user(@twitter_user).location
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
