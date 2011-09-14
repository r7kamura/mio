Mio::Application.routes.draw do
  get     "wiki" => "wiki#index", :as => :wiki_index
  delete  "wiki/:id" => "wiki#delete", :as => :wiki_delete
  get     "wiki/edit" => "wiki#edit", :as => :wiki_create
  get     "wiki/edit/:name" => "wiki#edit", :as => :wiki_edit
  post    "wiki/update"
  get     "wiki/:name" => "wiki#show", :as => :wiki_show
  get     "rooms" => "room#index", :as => :room_index
  get     "room/:name" => "room#show", :as => :room_show
  delete  "room/:id" => "room#delete", :as => :room_delete
  get     "tag/:name" => "tweet#hashtag", :as => :tweet_hashtag
  get     "user/setting"
  get     "users" => "user#index", :as => :user_index
  post    "user/update"
  get     "user/names"
  get     "user/:name" => "user#timeline", :as => :user_timeline
  get     "tweet/home"
  get     "tweet/show/:id" => "tweet#show", :as => :tweet_show
  get     "tweet/update_remote"
  get     "tweet/search"
  get     "tweet/new"
  get     "tweet/replies"
  post    "tweet/create"
  post    "tweet/favorite/:id" => "tweet#favorite", :as => :tweet_favorite
  post    "tweet/unfavorite/:id" => "tweet#unfavorite", :as => :tweet_unfavorite
  delete  "tweet/:id" => "tweet#delete", :as => :tweet_delete
  root :to => "tweet#home"

  devise_for :users
end
