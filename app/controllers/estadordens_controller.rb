class EstadordensController < ApplicationController
  # GET /estadordens
  # GET /estadordens.json
  def index
    @estadordens = Estadorden.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @estadordens }
    end
  end

  # GET /estadordens/1
  # GET /estadordens/1.json
  def show
    @estadorden = Estadorden.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @estadorden }
    end
  end

  # GET /estadordens/new
  # GET /estadordens/new.json
  def new
    @estadorden = Estadorden.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @estadorden }
    end
  end

  # GET /estadordens/1/edit
  def edit
    @estadorden = Estadorden.find(params[:id])
  end

  # POST /estadordens
  # POST /estadordens.json
  def create
    @estadorden = Estadorden.new(params[:estadorden])

    respond_to do |format|
      if @estadorden.save
        format.html { redirect_to @estadorden, notice: 'Estadorden was successfully created.' }
        format.json { render json: @estadorden, status: :created, location: @estadorden }
      else
        format.html { render action: "new" }
        format.json { render json: @estadorden.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /estadordens/1
  # PUT /estadordens/1.json
  def update
    @estadorden = Estadorden.find(params[:id])

    respond_to do |format|
      if @estadorden.update_attributes(params[:estadorden])
        format.html { redirect_to @estadorden, notice: 'Estadorden was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @estadorden.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estadordens/1
  # DELETE /estadordens/1.json
  def destroy
    @estadorden = Estadorden.find(params[:id])
    @estadorden.destroy

    respond_to do |format|
      format.html { redirect_to estadordens_url }
      format.json { head :ok }
    end
  end


  #arreglar esta cochinada de codigo, hacer con case.
  def nuevo
    @order = Order.find(params[:order_id])
    penultimoestado = @order.estadordens.last.estado
    @estadorden = Estadorden.create(user_id: session[:user_id],
                                                      order_id: @order.id,
                                                      estado: params[:estado])
    ultimoestado = @order.estadordens.last.estado
    if  ultimoestado== "Lista" || (ultimoestado=="Entregada" && penultimoestado!="Lista")
      @order.line_items.each do |l|
        producto = Product.find(l.product)
        c=(producto.cantidad-l.quantity)
        producto.update_attributes(cantidad: c)
      end

      Notifier.order_ready(@order).deliver

    elsif (penultimoestado != "Demorada" && ultimoestado == "Cancelada") || ultimoestado == "Demorada"
      @order.line_items.each do |l|
            producto = Product.find(l.product)
            c=(producto.cantidad+l.quantity)
            producto.update_attributes(cantidad: c)
      end
    end

    respond_to do |format|
      format.html {redirect_to @order}
    end
  end

end
