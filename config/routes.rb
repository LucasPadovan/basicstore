Tienda::Application.routes.draw do

  resources :estadordens

  resources :precioproductos

  resources :tipoproductos

  resources :mediopagos

  get 'admin' => 'admin#index'
  get 'contacto' => 'store#contacto'
  get 'preguntas' => 'store#faq'
  get 'novedades' => 'store#novedades'
  get 'productos' => 'store#productos'
  get 'nuevoEstado' => 'estadordens#nuevo'

  controller :session do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  scope '(:locale)' do
    resources :users
    resources :orders
    resources :line_items
    resources :carts

    resources :precioproductos

    resources :products do
      get :who_bought, :on => :member
    end

    root :to => 'store#index', :as => 'store'

    resources :orders do
       resources :mediopagos
    end
  end

  get '/products/:id/precionuevo' => "products#precionuevo", :as => :precionuevo
  post '/products/:id/precionuevo' => "products#guardarprecionuevo", :as => :precionuevo

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end