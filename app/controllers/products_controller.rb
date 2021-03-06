class ProductsController < ApplicationController
  before_filter :set_current_cart, only: :show
  skip_before_filter :authorize, only: :show

  def index
    @title = t('products.index.title')
    @products = Product.paginate page: params[:page], per_page: 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  def show
    @product = Product.find(params[:id])
    @related_promotions = Promotion.includes(:promotion_lines).where('promotion_lines.product_id = ?', @product.id)

    @products_in_cart = @cart.line_items.map(&:product_id)
    @promotions_in_cart = @cart.line_items.map(&:promotion_id)

    @title = @product.titulo

    set_page_meta_tags @title, @product.descripcion

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  def new
    @product = Product.new
    @prices = @product.precioproductos.build
    respond_to do |format|
      format.html # new.html.erb
      #format.xml  { render :xml => @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html {
          redirect_to( products_path, notice: 'Product was successfully created.')
        }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to( products_path, notice: 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    unless @product.destroy
      #todo: agregar los mensajes de error aca, los generados por los before filter del product
      notice = 'No se puede borrar por alguna razon'
    end

    respond_to do |format|
      format.html { redirect_to products_url, notice: notice }
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

  def precionuevo
    @product = Product.find(params[:id])
    @precioproducto = @product.precioproductos.build

    respond_to do |format|
      format.html #precionuevo.html.erb
      format.xml {render :xml => @product} #precionuevo.html.erb
    end
  end

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
