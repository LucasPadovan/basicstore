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
    set_page_meta_tags @title, nil

    @products = @products.paginate(page: params[:page], order: 'titulo ASC', per_page: 15)

    @products_in_cart = @cart.line_items.map(&:product_id)
  end

  def promotions
    @title = 'Promociones'
    @promotions = Promotion.published
    @promotions_in_cart = @cart.line_items.map(&:promotion_id)
    set_page_meta_tags @title, nil
  end

  def news
    @title = 'Noticias'
    @posts = Post.all_active
    set_page_meta_tags @title, nil
  end

  def about_us
    @title = 'Conozcanos'
    set_page_meta_tags @title, nil
  end

  def faq
    @title = 'Preguntas frecuentes'
    set_page_meta_tags @title, nil
  end
end
