Myheadway::Application.routes.draw do

  resources :docs
  resources :doc_types

  resources :attentions

  resources :notices

  resources :claims
  resources :tgroups
  resources :denials
  resources :books
  resources :statementstags
  resources :tags
  resources :feelings
  resources :target_days
  resources :targets
  resources :search_suggestions
  resources :statements
  resources :authors
  resources :attn_cats
  resources :task_cats
  resources :tasks
  resources :priorities
  
  get 'exchange1c/:model.json' => 'exchange1c#index'
  post 'exchange1c/:model/upload' => 'exchange1c#upload'

  get    'options'  => 'options#edit'
  get    'options/:options_page.json' => 'options#index'
  get    'options/:options_page'  => 'options#edit',:constraints => {:format => /(json|html)/}
  post   'options/upload/:options_page' => 'options#upload'
  post   'options/:options_page' => 'options#create'
  delete 'options/:options_page/:id' => 'options#destroy'
  post "ajax/upd_param"
  post "ajax/add_option"


  root :to => "statements#index"

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'                                   
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]


  get "ajax/authors"
  get "ajax/books"
  get "ajax/targets"
  post "ajax/target_days"

  resources :statements
  resources :authors

  get "targets/period/:year(/:month(/:day))" => "targets#index", :constraints => { :year => /\d{4}/, :month => /\d+/, :day => /\d{2}/ }


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
