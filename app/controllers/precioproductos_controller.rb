class PrecioproductosController < ApplicationController
  # GET /precioproductos
  # GET /precioproductos.json
  def index
    @producto = Product.find(params[:product])
    @precioproductos = Precioproducto.find_all_by_product_id(@producto)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @precioproductos }
    end
  end

  # GET /precioproductos/new
  # GET /precioproductos/new.json
  def new
    @precioproducto = Precioproducto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @precioproducto }
    end
  end

  # GET /precioproductos/1/edit
  def edit
    @precioproducto = Precioproducto.find(params[:id])
  end

  # POST /precioproductos
  # POST /precioproductos.json
  def create
    @precioproducto = Precioproducto.new(params[:precioproducto])

    respond_to do |format|
      if @precioproducto.save
        format.html { redirect_to @precioproducto, notice: 'Precioproducto was successfully created.' }
        format.json { render json: @precioproducto, status: :created, location: @precioproducto }
      else
        format.html { render action: "new" }
        format.json { render json: @precioproducto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /precioproductos/1
  # PUT /precioproductos/1.json
  def update
    @precioproducto = Precioproducto.find(params[:id])

    respond_to do |format|
      if @precioproducto.update_attributes(params[:precioproducto])
        format.html { redirect_to @precioproducto, notice: 'Precioproducto was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @precioproducto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /precioproductos/1
  # DELETE /precioproductos/1.json
  def destroy
    @precioproducto = Precioproducto.find(params[:id])
    @precioproducto.destroy

    respond_to do |format|
      format.html { redirect_to precioproductos_url }
      format.json { head :ok }
    end
  end
end
