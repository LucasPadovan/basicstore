class ProductsController < ApplicationController
  skip_before_filter :authorize, :only => :show
  # GET /products
  # GET /products.xml
  def index
    @products = Product.paginate :page=>params[:page],:per_page => 17

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    @precio_actual = @product.precioproductos.last

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @precioproducto = @product.precioproductos.build

    respond_to do |format|
      format.html # new.html.erb
      #format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @precioproducto = @product.precioproductos.last
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])
    @precioproducto = @product.precioproductos.build(params[:precioproducto])

    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    respond_to do |format|
      format.atom
      format.xml {render :xml => @product}
    end      
  end

  #GET /product/precionuevo
  def precionuevo
    @product = Product.find(params[:id])
    @precioproducto = @product.precioproductos.build

    respond_to do |format|
      format.html #precionuevo.html.erb
      format.xml {render :xml => @product} #precionuevo.html.erb
    end
  end

  #POST /product/guardarprecionuevo
  def guardarprecionuevo
    #validacion usuario

    if Product.exists?(params[:id])
      @product = Product.find(params[:id])
      @precioproducto = @product.precioproductos.build(params[:precioproducto])

    else
      redirect_to(products_path, :notice => "Especifique un producto valido")
    end

    respond_to do |format|
      if @precioproducto.save
        format.html {redirect_to(@product, :notice =>"El nuevo precio fue agregado satisfactoriamente")}
        format.xml {@product}
      else
        format.html {render :action => "new"}
      end
    end
  end

end
