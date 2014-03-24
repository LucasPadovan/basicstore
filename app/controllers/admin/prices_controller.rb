class Admin::PricesController < Admin::AdminController
  before_filter :get_product, only: [:new, :create]

  def index
    @product = Product.includes(:prices).find(params[:id])
    @prices = @product.prices.order('created_at DESC')
    @title = t('prices.index.title', product: @product.titulo)
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
    @price = Price.new(params[:price])

    if @price.save
      js_notify message: 'bien creado ql'
      render partial: 'price', locals: { cost: @price.cost, price: @price.public_price }, content_type: 'text/html'
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  private
  def get_product
    @product = Product.find(params[:id])
  end
end
