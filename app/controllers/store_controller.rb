class StoreController < ApplicationController

  require 'will_paginate/array'

  before_filter :set_current_cart

  skip_before_filter :authorize
  
  def index
    if params[:product_type].present?
      @title = params[:product_type]
      @product_type = Tipoproducto.includes(:products).where('tipoproductos.nombre = ?' , params[:product_type]).first
      @products = @product_type.products
    else
      @title = 'Ultimos productos agregados'
      @products = Product.novedades
    end
    @products = @products.paginate(page: params[:page], order: 'titulo ASC', per_page: 15)
  end

  def promotions

  end

  protected
  def set_current_cart
    @cart = current_cart
  end
end
