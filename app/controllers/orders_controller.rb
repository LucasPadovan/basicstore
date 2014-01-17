class OrdersController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create, :show]

  require 'will_paginate/array'

  # GET /orders
  # GET /orders.xml
  def index
    @title = t('orders.index.title')
    if params[:estadoOrden]
      @o = Order.buscarEstado(params[:estadoOrden])
      @orders = @o.paginate page: params[:page], order: 'created_at desc'

    else
      @orders = Order.paginate page: params[:page], order: 'created_at desc',
        per_page: 15

    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end

  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])
    @title = t('orders.show.title', number: @order.number)

    unless @order.estadordens.count > 1
      @estado = Estadorden.create(user_id: session[:user_id], order_id: @order.id, estado: 'Leido') if session[:user_id].present?
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_index_url, notice: 'Su carro esta vacio'
      return
    end
    
    @order = Order.new

    render partial: 'new', content_type: 'text/html'
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)

    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      OrderMailer.received(@order).deliver
      js_redirect to: order_path(@order)
    else
      @cart = current_cart
      render partial: 'new', status: :unprocessable_entity
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end

  def nuevo
    #evitar hacer dos iguales consecutivas
    @order = Order.find(params[:order_id])
    #noanda
    @estadorden = Estadorden.create(user_id: params[:user_id],order_id: @order.id,
                                                                estado: params[:estado])
    respond_to do |format|
      format.html { redirect_to @order }
    end

  end

end
