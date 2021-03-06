Rails.application.routes.draw do
  # Static Pages Routes
  root 'static_pages#index'
  get 'about' => 'static_pages#about'

  # Users Routes
  resources :users
  get 'dashboard' => 'users#show'

  # Sign Up Routes
  get 'signup' => 'users#new'

  # Log In/Log Out Routes
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :activations, only: [:edit]

  resources :resets, only: [:new, :create, :edit, :update]

  # Subscriptions Routes
  resources :subscriptions, only: [:index, :new, :create, :update]
  get 'subscriptions/manage' => 'subscriptions#manage'
  delete 'subscriptions/destroy_multiple' => 'subscriptions#destroy_multiple'
  get 'subscriptions/export' => 'subscriptions#export', defaults: { :format => 'xml' }
  get 'mydigest' => 'subscriptions#index'

  # Sites Routes
  resources :sites, only: [:show]
  get 'browse' => 'sites#index'
  
  resources :stashes, only: [:index, :create, :destroy]

  # Sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

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
