Rails.application.routes.draw do


  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get 'articles_tags/:tag', to: 'articles#index', as: :articles_tag
    get 'books_tags/:tag', to: 'books#index', as: :books_tag
    get "/pages/*id" => 'pages#show', as: :page, format: false

    devise_for :users, path_names: {
                         sign_up: 'register',
                         sign_in: 'log_in',
                         sign_out: 'log_out',
                     }
    mount Ckeditor::Engine => '/ckeditor'
    resources :books do
      resources :comments
    end
    resources :articles do
      resources :comments
    end
    resources :roles
  end
  get 'sitemap' => 'welcome#sitemap'
  get 'feed', to: 'welcome#feed', format: 'rss'
  get 'robots' => 'welcome#robots', format: :text

  root 'welcome#index'
  # match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), via: :all
  # match '', to: redirect("/#{I18n.default_locale}"), via: :all
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
