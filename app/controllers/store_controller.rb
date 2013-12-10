class StoreController < ApplicationController

  require 'will_paginate/array'

  before_filter :set_current_cart

  skip_before_filter :authorize
  
  def index
    product_type = params[:product_type] || 'Novedades'
    @title = product_type
    @products = Product.includes(:product_types).where('product_types.name = ?' , product_type)
    @products = @products.paginate(page: params[:page], order: 'titulo ASC', per_page: 15)
  end

  def promotions
    @promotions = Promotion.published
  end

  protected
  def set_current_cart
    @cart = current_cart
  end
end
