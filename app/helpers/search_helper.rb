module SearchHelper
  COUNTS = ["followers", "friends", "statuses", "favourites", "listed"]
  class << self
    COUNTS.each do |item|
      define_method("#{item}_count") do
        $client.user(current_user).("#{item}_count").to_sym
      end
    end
  end
end
