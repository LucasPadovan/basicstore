class Admin::PricesController < Admin::AdminController
  before_filter :get_product, only: [:new, :create]

  def index
    @product = Product.includes(:prices).find(params[:product_id])
    @prices = @product.prices.order('created_at DESC')
    @title = t('admin.prices.index.title', product: @product.titulo)
    respond_to do |format|
      format.html
      format.json { render json: @prices }
    end
  end

  def new
    @title = t('admin.prices.new.title', product: @product)
    @price = @product.prices.new

    render partial: 'new', content_type: 'text/html'
  end

  def create
    @title = t('admin.prices.new.title', product: @product)
    @price = @product.prices.build(params[:price])

    if @price.save
      js_notify message: t('admin.prices.create.success'), type: 'alert-success', time: 2500
      render partial: 'price', locals: { cost: @price.cost, price: @price.public_price }, content_type: 'text/html'
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  private
  def get_product
    @product = Product.find(params[:product_id])
  end
end
