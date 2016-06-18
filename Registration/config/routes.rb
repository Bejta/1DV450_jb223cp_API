
Rails.application.routes.draw do
  mount Knock::Engine => "/knock"  
  
  namespace :api , defaults: {format: 'json'} do
    namespace :v1 do
      
      #Resource model Pub
      resources :pubs do
        resources :positions, only: [:index]
        resources :tags, only: [:index]
      end
      
      #Resource model Position
      resources :positions, only: [:show, :index, :create, :new, :destroy, :update]
            resources :tags, only: [:show, :index, :create, :new, :destroy, :update] do
            resources :toilets, only: [:index]
      end
      
      #Resource model Creator
      resources :creators, only: [:show, :index] do
        resources :toilets, only: [:index]
      end

        get 'creator_by_name' => 'creators#creator_by_name'
    end
  end
  
  
  #root of the site, session controller with action method index
  root 'sessions#index'
  
  # Delete client 
  delete 'delete_client/:id' => 'clients#delete', as: :delete_client
  
  # Delete client 
  delete 'delete_client/:id' => 'admins#delete', as: :admin_delete_client
  
  #Revoke client
  post 'revoke_client/:id' => 'admins#revoke', as: :revoke_client
  
  #Delete user
  post 'destroy_user/:id' => 'admins#destroy', as: :destroy_user
  
  #login and logout
  post 'login' => 'sessions#login', as: :login
  get 'logout' => 'sessions#logout', as: :logout
  
  get 'users' => 'users#new', as: :new_user 
  get 'clients' => 'clients#show', as: :client
  
  get 'admins' => 'admins#show', as: :admin
  
  resources :users
  resources :clients
  resources :admins
  
  get 'apikeys' => 'apikeys#show', as: :apikey
  
  
  
  #resources admin
  
  
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
