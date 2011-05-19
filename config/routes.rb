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
  get     "tag/:name" => "hash_tag#show", :as => :hash_tag_show
  get     "user/setting"
  get     "users" => "user#index", :as => :user_index
  post    "user/update"
  get     "user/:name" => "user#timeline", :as => :user_timeline
  get     "tweet/home"
  get     "tweet/show/:id" => "tweet#show", :as => :tweet_show
  get     "tweet/update_remote"
  get     "tweet/search"
  get     "tweet/new"
  post    "tweet/create"
  post    "tweet/favorite/:id" => "tweet#favorite", :as => :tweet_favorite
  post    "tweet/unfavorite/:id" => "tweet#unfavorite", :as => :tweet_unfavorite
  delete  "tweet/:id" => "tweet#delete", :as => :tweet_delete
  root :to => "tweet#home"

  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
