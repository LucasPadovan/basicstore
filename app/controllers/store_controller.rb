class StoreController < ApplicationController

  require 'will_paginate/array'

  before_filter :set_current_cart

  skip_before_filter :authorize
  
  def index
    product_type = params[:product_type] || 'Novedades'
    if params[:search]
      product_type = "Productos que responden a <#{params[:search]}>"
      search = "%#{params[:search].downcase}%"
      @products = Product.where('lower(titulo) LIKE :title OR lower(descripcion) LIKE :description', title: search, description: search)
    else
      @products = ProductType.where(name: product_type).first.products
    end

    @title = product_type

    @products = @products.paginate(page: params[:page], order: 'titulo ASC', per_page: 15)

    @products_in_cart = @cart.line_items.map(&:product_id)
  end

  def promotions
    @title = 'Promociones'
    @promotions = Promotion.published
    @promotions_in_cart = @cart.line_items.map(&:promotion_id)
  end

  def news
    @title = 'Noticias'
    @posts = Post.all_active
  end

  def about_us
    @title = 'Conozcanos'
  end

  def faq
    @title = 'Preguntas frecuentes'
  end
end
