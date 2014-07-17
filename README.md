TwitterThing
============
Up on [heroku](http://afternoon-oasis-1116.herokuapp.com/).

Search for tweets/people.
See their profiles.
See where they tweet from.

####Design considerations
If the selected user doesn't tweet with geo location enabled, I just put the profile location on the map.
JS/Theme is from [vandre](http://github.com/astuyve/vandre), which is based off of [RailsGirls](http://railsgirls.com).

####DB
Postgres for heroku.

####Gems
Uses Twitter and OmniAuth-twitter. Also figaro to manage keys/tokens.
