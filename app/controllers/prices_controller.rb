class PricesController < ApplicationController

  def index
    @product = Product.includes(:prices).find(params[:id])
    @prices = @product.prices
    @title = t('prices.index.title', product: @product.titulo)
    respond_to do |format|
      format.html { render 'admin/prices/index' }# index.html.erb
      format.json { render json: @prices }
    end
  end

  def new
    @precioproducto = Price.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @precioproducto }
    end
  end

  def create
    @precioproducto = Price.new(params[:precioproducto])

    respond_to do |format|
      if @precioproducto.save
        format.html { redirect_to @precioproducto, notice: 'Price was successfully created.' }
        format.json { render json: @precioproducto, status: :created, location: @precioproducto }
      else
        format.html { render action: "new" }
        format.json { render json: @precioproducto.errors, status: :unprocessable_entity }
      end
    end
  end
end
