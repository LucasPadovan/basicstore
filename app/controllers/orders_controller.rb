class OrdersController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create, :show]

  # GET /orders
  # GET /orders.xml
  def index
    #todo: index para el usuario
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])
    @title = t('orders.show.title', number: @order.number)
    set_page_meta_tags @title, nil
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
