class StoreController < ApplicationController

  require 'will_paginate/array'

  before_filter :set_current_cart

  skip_before_filter :authorize
  
  def index
    product_type = params[:product_type] || 'Novedad'
    @title = product_type
    @product_type = ProductType.includes(:products).where('product_types.name = ?' , product_type).first
    @products = @product_type.products
    @products = @products.paginate(page: params[:page], order: 'titulo ASC', per_page: 15)
  end

  def promotions

  end

  protected
  def set_current_cart
    @cart = current_cart
  end
end
