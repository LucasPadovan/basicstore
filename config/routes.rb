Tienda::Application.routes.draw do
  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  resources :estadordens

  resources :precioproductos

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

  resources :store, only: :index do
    collection do
      match '/:product_type', to: 'store#index', via: :get
    end
  end
  resources :orders, only: [:show, :new, :create]
  resources :line_items
  resources :carts, except: [:new, :edit, :index]

  resources :precioproductos

  resources :products do
    get :who_bought, on: :member
  end

  root to: 'store#promotions', as: 'promociones'

  get '/products/:id/precionuevo' => "products#precionuevo", as: :precionuevo
  post '/products/:id/precionuevo' => "products#guardarprecionuevo", as: :precionuevo

  namespace :admin do
    resources :orders, only: [:index, :show, :destroy]
    resources :payment_methods, except: :show
    resources :posts
    resources :product_types
    resources :promotions do
      resources :promotion_lines, as: :lines, except: [:index, :show]
      member do
        put :publish
        put :unpublish
      end
    end
    resources :users
  end
end
