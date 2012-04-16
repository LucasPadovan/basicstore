class TipoproductosController < ApplicationController
  # GET /tipoproductos
  # GET /tipoproductos.json
  def index
    @tipoproductos = Tipoproducto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipoproductos }
    end
  end

  # GET /tipoproductos/1
  # GET /tipoproductos/1.json
  def show
    @tipoproducto = Tipoproducto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipoproducto }
    end
  end

  # GET /tipoproductos/new
  # GET /tipoproductos/new.json
  def new
    @tipoproducto = Tipoproducto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipoproducto }
    end
  end

  # GET /tipoproductos/1/edit
  def edit
    @tipoproducto = Tipoproducto.find(params[:id])
  end

  # POST /tipoproductos
  # POST /tipoproductos.json
  def create
    @tipoproducto = Tipoproducto.new(params[:tipoproducto])

    respond_to do |format|
      if @tipoproducto.save
        format.html { redirect_to @tipoproducto, notice: 'Tipoproducto was successfully created.' }
        format.json { render json: @tipoproducto, status: :created, location: @tipoproducto }
      else
        format.html { render action: "new" }
        format.json { render json: @tipoproducto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tipoproductos/1
  # PUT /tipoproductos/1.json
  def update
    @tipoproducto = Tipoproducto.find(params[:id])

    respond_to do |format|
      if @tipoproducto.update_attributes(params[:tipoproducto])
        format.html { redirect_to @tipoproducto, notice: 'Tipoproducto was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipoproducto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipoproductos/1
  # DELETE /tipoproductos/1.json
  def destroy
    @tipoproducto = Tipoproducto.find(params[:id])
    @tipoproducto.destroy

    respond_to do |format|
      format.html { redirect_to tipoproductos_url }
      format.json { head :ok }
    end
  end
end
