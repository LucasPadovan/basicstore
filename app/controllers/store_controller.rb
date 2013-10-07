class StoreController < ApplicationController

  require 'will_paginate/array'

  before_filter :set_current_cart

  skip_before_filter :authorize
  
  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
      @products = Product.novedades
    end
  end

  def productos
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    elsif params[:tipoprod].present?
      @products = Product.buscartipo(params[:tipoprod])
      @tp= Tipoproducto.find(params[:tipoprod]).nombre
      @products = @products.paginate(page: params[:page], order: 'titulo ASC', per_page: 15)
    else
      @products = Product.paginate(page: params[:page], order: 'titulo ASC', per_page: 15)
    end
  end

  protected
  def set_current_cart
    @cart = current_cart
  end
end
