Tienda::Application.routes.draw do
  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  resources :posts

  resources :estadordens

  resources :promotions do
    resources :promotion_lines, as: :lines, except: [:index, :show]
    member do
      put :publish
      put :unpublish
    end
  end

  resources :precioproductos

  resources :product_types

  resources :mediopagos

  get 'admin' => 'admin#index'
  get 'contacto' => 'store#contacto'
  get 'preguntas' => 'store#faq'
  get 'novedades' => 'store#news'
  get 'conozcanos' => 'store#about_us'

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
      get :who_bought, on: :member
    end

    root to: 'store#promotions', as: 'promociones'

    resources :orders do
       resources :mediopagos
    end
  end

  get '/products/:id/precionuevo' => "products#precionuevo", as: :precionuevo
  post '/products/:id/precionuevo' => "products#guardarprecionuevo", as: :precionuevo
end
