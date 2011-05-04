Mio::Application.routes.draw do
  match "wiki" => "wiki#index", :as => :wiki_index
  match "wiki/update/:id" => "wiki#update", :as => :wiki_update
  match "wiki/delete/:id" => "wiki#delete", :as => :wiki_delete
  match "wiki/update" => "wiki#update", :as => :wiki_update
  match "wiki/edit" => "wiki#edit", :as => :wiki_create
  match "wiki/edit/:name" => "wiki#edit", :as => :wiki_edit
  match "wiki/:name" => "wiki#show", :as => :wiki_show
  get   "room/index"
  match "room/:name" => "room#show", :as => :room_show
  match "tag/:name" => "hash_tag#show", :as => :hash_tag_show
  get   "user/setting"
  get   "user/index"
  post  "user/update"
  match "user/:name" => "user#timeline", :as => :user_timeline
  get   "tweet/home"
  get   "tweet/update_remote"
  post  "tweet/create"
  match "tweet/favorite/:id" => "tweet#favorite", :as => :tweet_favorite
  match "tweet/unfavorite/:id" => "tweet#unfavorite", :as => :tweet_unfavorite
  match "tweet/delete/:id" => "tweet#delete", :as => :tweet_delete
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
