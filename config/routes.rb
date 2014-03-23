Tienda::Application.routes.draw do
  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  get 'contacto' => 'store#contacto'
  get 'preguntas' => 'store#faq'
  get 'novedades' => 'store#news'
  get 'conozcanos' => 'store#about_us'

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

  # todo: este deberia irse
  resources :estadordens
  get 'nuevoEstado' => 'estadordens#nuevo'

  get '/products/:id/precionuevo' => "products#precionuevo", as: :precionuevo
  post '/products/:id/precionuevo' => "products#guardarprecionuevo", as: :precionuevo

  resources :products, only: :show

  root to: 'store#promotions', as: 'promociones'

  namespace :admin do
    resources :orders, only: [:index, :show, :destroy]
    resources :payment_methods, except: :show
    resources :posts
    resources :product_types
    resources :products do
      member do
        resources :prices, only: [:index, :new, :create]
      end
    end
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
