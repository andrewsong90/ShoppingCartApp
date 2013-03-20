Andrew90Proj2::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"


  get "/carts" => "carts#index", :as => "carts"
  match "/carts/:id/add" => "carts#add_item",  :as => "add"
  match "/carts/:id/update" => "carts#update_item", :as => "cart_item_update"
  match "/carts/:id/remove" => "carts#remove_item", :as => "cart_item_remove"
  match "/carts/save_to_list" => "carts#save_to_list", :as => "cart_to_list"

  match "/lists/add/:id" => "lists#add_item", :as => "list_add_item"
  match "/lists/update/:id" => "lists#update_item_quantity", :as => "list_update_item"
  match "/lists/:num/remove/:id" => "lists#remove_item", :as => "list_remove_item"
  match "/lists/search" => "lists#search", :as => "list_search"
  match "/lists/others/:id" => "lists#others", :as => "list_others" #try converting it into "/lists/index/others"
  match "/lists/:id/import_to_cart" => "lists#import_to_cart", :as => "import_to_cart"

  match "orders/confirm" => "orders#confirm", :as => "order_confirm"
  match "items/myItems" => "items#myItems", :as => "my_item"
  match "items/index_categories" => "items#index_categories", :as => "items_categories"
  match "users/account" => "users#account", :as => "user_account"

  resources :users
  resources :sessions
  resources :items
  resources :orders
  resources :lists
  resources :categories



  root :to => "items#index"
  
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
