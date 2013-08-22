PixApp::Application.routes.draw do

  # Devise Routes
  authenticated :user do
    get '/' => 'dashboards#show'
  end
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  get "/dashboard/category/:category_id" => 'dashboards#show'
  get "/dashboard/sub_category/:sub_category_id" => 'dashboards#show'
  get "/dashboard/posts/:post_type" => 'dashboards#show'
  resource :dashboard
  resources :posts, except: [:index]  do
    put 'mark_favourite' => 'posts#mark_favourite'
    resources :photos, :only => [:create, :destroy]
  end
  get "/comments/:id/older/:post_id" => 'comments#older'
  get "/comments/:recent_comment_id/recent/:post_id" => 'comments#recent'
  resources :comments, only: [:create, :destroy]
  resources :users, except: [:show]
  resources :categories
  resources :sub_categories


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
