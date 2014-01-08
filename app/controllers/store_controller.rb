class StoreController < ApplicationController

  require 'will_paginate/array'

  before_filter :set_current_cart

  skip_before_filter :authorize
  
  def index
    product_type = params[:product_type] || 'Novedades'
    @title = product_type
    @products = Product.includes(:product_types).where('product_types.name = ?' , product_type)
    @products = @products.paginate(page: params[:page], order: 'titulo ASC', per_page: 15)

    @products_in_cart = @cart.line_items.map(&:product_id)
  end

  def promotions
    @promotions = Promotion.published
    @promotions_in_cart = @cart.line_items.map(&:promotion_id)
  end

  def news
    @posts = Post.all_active
  end
end
