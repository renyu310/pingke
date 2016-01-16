Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/index'

  root 'static_pages#home'

  get 'about' => 'static_pages#about'

  get 'help' => 'static_pages#help'

  get 'sign_up' => 'users#new'

  get 'login'   => 'sessions#new'
  post 'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'




  resources :users do
    member do
      get :following, :followers
    end
  end


  resources :courses

  resources :comments, only: [:create,:destroy]


  get 'search' => "courses#search"
  post 'search' => 'courses#search'

  get 'filters' => "courses#filter_courses"
  post 'filters' => 'courses#filter_courses'

  post 'follow_course' => 'courses#followcourse'
  post 'unfollow_course' => 'courses#unfollowcourse'

  post 'put_zan_course' => 'courses#putZan'

  resources :microposts, only: [:create, :destroy]

  resources :relationships, only: [:create, :destroy]


  resources :users do
    collection do
      get :tigers
    end
  end

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
