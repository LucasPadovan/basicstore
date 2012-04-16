class MediopagosController < ApplicationController
  # GET /mediopagos
  # GET /mediopagos.xml
  def index
    @mediopagos = Mediopago.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mediopagos }
    end
  end

  # GET /mediopagos/1
  # GET /mediopagos/1.xml
  def show
    @mediopago = Mediopago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mediopago }
    end
  end

  # GET /mediopagos/new
  # GET /mediopagos/new.xml
  def new
    @mediopago = Mediopago.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mediopago }
    end
  end

  # GET /mediopagos/1/edit
  def edit
    @mediopago = Mediopago.find(params[:id])
  end

  # POST /mediopagos
  # POST /mediopagos.xml
  def create
    @mediopago = Mediopago.new(params[:mediopago])

    respond_to do |format|
      if @mediopago.save
        format.html { redirect_to(@mediopago, :notice => 'Mediopago was successfully created.') }
        format.xml  { render :xml => @mediopago, :status => :created, :location => @mediopago }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mediopago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mediopagos/1
  # PUT /mediopagos/1.xml
  def update
    @mediopago = Mediopago.find(params[:id])

    respond_to do |format|
      if @mediopago.update_attributes(params[:mediopago])
        format.html { redirect_to(@mediopago, :notice => 'Mediopago was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mediopago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mediopagos/1
  # DELETE /mediopagos/1.xml
  def destroy
    @mediopago = Mediopago.find(params[:id])
    @mediopago.destroy

    respond_to do |format|
      format.html { redirect_to(mediopagos_url) }
      format.xml  { head :ok }
    end
  end
  
    def autocompletar
    @mediopago = Mediopago.tipo_pago(params[:term])
    
    respond_to do |format|
      format.js {render text: @mediopago.map(:nombre)}
    end
  end
end
