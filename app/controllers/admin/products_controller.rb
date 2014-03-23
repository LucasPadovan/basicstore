class Admin::ProductsController < Admin::AdminController

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

    render partial: 'new', content_type: 'text/html'
  end

  def edit
    @product = Product.find(params[:id])

    render partial: 'edit', content_type: 'text/html'
  end

  def create
    @product = Product.new(params[:product])

    if @product.save
      js_notify message: t('admin.products.create.success'), type: 'alert-success', time: 2500
      render partial: 'product', content_type: 'text/html', locals: { product: @product }
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      js_notify message: t('admin.products.update.success'), type: 'alert-success', time: 2500
      render partial: 'product', content_type: 'text/html', locals: { product: @product }
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      js_notify message: t('admin.products.destroy.success'), type: 'alert-error', time: 2500
      render nothing: true, content_type: 'text/html'
    else
      message = "#{t('admin.products.destroy.error')}: #{@product.errors[:base].first}"
      js_notify message: message, type: 'alert-info', time: 2500
      render nothing: true
    end
  end

  # todo: esto volarlo
  def precionuevo
    @product = Product.find(params[:id])
    @precioproducto = @product.precioproductos.build

    respond_to do |format|
      format.html #precionuevo.html.erb
      format.xml {render :xml => @product} #precionuevo.html.erb
    end
  end

  def guardarprecionuevo
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
