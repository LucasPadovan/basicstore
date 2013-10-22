Tienda::Application.routes.draw do

  resources :estadordens

  resources :promotions

  resources :precioproductos

  resources :product_types

  resources :mediopagos

  get 'admin' => 'admin#index'
  get 'contacto' => 'store#contacto'
  get 'preguntas' => 'store#faq'
  get 'nuevoEstado' => 'estadordens#nuevo'

  controller :session do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  scope '(:locale)' do
    resources :store, only: :index do
      collection do
        match '/:product_type', to: 'store#index', via: :get
      end
    end
    resources :users
    resources :orders
    resources :line_items
    resources :carts

    resources :precioproductos

    resources :products do
      get :who_bought, :on => :member
      resources :promotions
    end

    root :to => 'store#promotions', :as => 'promociones'

    resources :orders do
       resources :mediopagos
    end
  end

  get '/products/:id/precionuevo' => "products#precionuevo", :as => :precionuevo
  post '/products/:id/precionuevo' => "products#guardarprecionuevo", :as => :precionuevo
end
