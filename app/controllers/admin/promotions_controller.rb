class Admin::PromotionsController < Admin::AdminController
  before_filter :get_product, except: :index

  # GET /promotions
  # GET /promotions.json
  def index
    @title = t('admin.promotions.index.title')
    @promotions = ( @product ? @product.promotions : Promotion.all )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @promotions }
    end
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show
    @promotion = Promotion.includes(:promotion_lines).find(params[:id])
    @promotion_lines = @promotion.promotion_lines
    @title = "Promocion: #{@promotion.title}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @promotion }
    end
  end

  # GET /promotions/new
  # GET /promotions/new.json
  def new
    @title = t('admin.promotions.new.title')
    @promotion = Promotion.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @promotion }
    end
  end

  # GET /promotions/1/edit
  def edit
    @title = t('admin.promotions.edit.title')
    @promotion = Promotion.find(params[:id])
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @title = t('admin.promotions.new.title')
    @promotion = Promotion.new params[:promotion]
    @promotion.state = 'not-published'
    respond_to do |format|
      if @promotion.save
        format.html { redirect_to ['admin', @promotion], notice: 'Promotion was successfully created.' }
        format.json { render json: @promotion, status: :created, location: @promotion }
      else
        format.html { render action: 'new' }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /promotions/1
  # PUT /promotions/1.json
  def update
    @title = t('admin.promotions.edit.title')
    @promotion = Promotion.find(params[:id])
    params[:promotion][:state] = 'not-published'

    respond_to do |format|
      if @promotion.update_attributes(params[:promotion])
        format.html { redirect_to ['admin', @promotion], notice: 'Promotion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
  def destroy
    @promotion = Promotion.find(params[:id])

    if @promotion.destroy
      js_notify message: t('admin.promotions.destroy.success'), type: 'alert-error', time: 2500
      render nothing: true, content_type: 'text/html'
    else
      message = "#{t('admin.promotions.destroy.error')}: #{@promotion.errors[:base].first}"
      js_notify message: message, type: 'alert-info', time: 2500
      render nothing: true
    end
  end

  def preview
    render partial: 'preview', content_type: 'text/html'
  end

  def publish
    @promotion = Promotion.find(params[:id])
    @promotion.publish
    js_notify message: 'Promocion visible al publico'
    render partial: 'state', content_type: 'text/html'
  end

  def unpublish
    @promotion = Promotion.find(params[:id])
    @promotion.unpublish
    js_notify message: 'Promocion oculta al publico'
    render partial: 'state', content_type: 'text/html'
  end

  private
  def get_product
    @product = Product.find(params[:product_id]) if params[:product_id]
  end
end
