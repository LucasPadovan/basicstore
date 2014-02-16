class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :set_locale
  before_filter :get_product_types
  before_filter :set_page_meta_tags
  protect_from_forgery

  protected
  def set_locale
    I18n.locale = :es
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

  def set_page_meta_tags(title = nil, description = nil)
    @page_title = title ? title + ' - ' : ''
    @page_title += t('layouts.application.title')

    @page_description = description ? description + ' - ' : ''
    @page_description += t('layouts.application.page_description')
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
