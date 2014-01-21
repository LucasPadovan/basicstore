class Admin::ProductTypesController < Admin::AdminController

  def index
    @title = t('admin.product_types.index.title')
    q = "%#{params[:q]}%"
    @product_types = ProductType.where('lower(name) LIKE :query', query: q).order(:position)
    respond_to do |format|
      format.html
      format.json { render json: @product_types.map(&:attributes) }
    end
  end

  def show
    @product_type = ProductType.find(params[:id])
    @title = t('admin.product_types.show.title', name: @product_type.name)

    render partial: 'show', content_type: 'text/html'
  end

  def new
    @product_type = ProductType.new
    render partial: 'new', content_type: 'text/html'
  end

  def edit
    @product_type = ProductType.find(params[:id])
    render partial: 'edit', content_type: 'text/html'
  end

  def create
    @product_type = ProductType.new(params[:product_type])

    if @product_type.save
      js_notify message: t('admin.product_types.create.success'), type: 'alert-success', time: 2500
      render partial: 'product_type', content_type: 'text/html', locals: { product_type: @product_type }
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  def update
    @product_type = ProductType.find(params[:id])

    if @product_type.update_attributes(params[:product_type])
      js_notify message: t('admin.product_types.update.success'), type: 'alert-success', time: 2500
      render partial: 'product_type', content_type: 'text/html', locals: { product_type: @product_type }
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @product_type = ProductType.find(params[:id])

    if @product_type.destroy
      js_notify message: t('admin.product_types.destroy.success'), type: 'alert-error', time: 2500
      render nothing: true, content_type: 'text/html'
    else
      message = "#{t('admin.product_types.destroy.error')}: #{@product_type.errors[:base].first}"
      js_notify message: message, type: 'alert-info', time: 2500
      render nothing: true
    end
  end
end
