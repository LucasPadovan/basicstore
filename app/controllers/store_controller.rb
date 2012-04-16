class StoreController < ApplicationController

  require 'will_paginate/array'

  skip_before_filter :authorize
  
  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else      
      @products = Product.last(5)
      @cart = current_cart
    end
  end

  def productos
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    elsif params[:tipoprod].present?
      @p = Product.buscartipo(params[:tipoprod])
      @tp= Tipoproducto.find(params[:tipoprod]).nombre
      @prod = @p.paginate(:page=>params[:page], :order=>'created_at desc', :per_page => 15)
    else
      @products = Product.paginate :page=>params[:page], :order=>'created_at desc', :per_page => 15
    end
    @cart = current_cart
  end

end
