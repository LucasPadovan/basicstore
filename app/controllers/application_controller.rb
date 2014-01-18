class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :set_i18n_locale_from_params
  before_filter :get_product_types
  protect_from_forgery

  protected
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        I18n.locale = :es
        flash.now[:notice] =
          "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  #todo: sacar esto para sacar el locale=es de la url, tengo que rehacer los controladores y cambiarlos a admin y eso.
  def default_url_options
    {:locale => I18n.locale}
  end

  #todo: quitar esto y poner devise
  def authorize
    unless User.find(session[:user_id])
      redirect_to login_url, notice: 'Por favor ingrese al sistema'
    end
  end

  def get_product_types
    @product_types= ProductType.order(:position).all
  end

  def current_user
    User.find(session[:user_id])
  end

  def set_current_cart
    @cart = current_cart
  end

  private
  def current_cart
    Cart.find( session[:cart_id] )
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
