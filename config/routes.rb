Ratebeer::Application.routes.draw do
  resources :memberships

  resources :beer_clubs

  resources :users

  resources :beers

  resources :breweries do
    post 'toggle_activity', on: :member
  end
  
  resources :ratings, :only => [:index, :new, :create, :destroy]

  resources :sessions, only: [:new, :create]

  resources :places, only:[:index, :show]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'breweries#index'

  get 'ratings', to: 'ratings#index'
  get 'ratings/new', to:'ratings#new'
  post 'ratings', to: 'ratings#create'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
get 'auth/:provider/callback', to: 'sessions#create_fb'
get 'auth/failure', to: redirect('/')
get 'signout', to: 'sessions#destroy', as: 'signout'
  delete 'signout', to: 'sessions#destroy'
  post 'places', to:'places#search'
  get 'beerlist', to:'beers#list'
  get 'ngbeerlist', to:'beers#nglist'
  get 'brewerylist', to:'breweries#list'

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
