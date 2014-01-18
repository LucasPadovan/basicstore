class Admin::PaymentMethodsController < Admin::AdminController
  # GET /payment_methods
  # GET /payment_methods.xml
  def index
    @title = t('admin.payment_methods.index.title')
    @payment_methods = PaymentMethod.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payment_methods }
    end
  end

  # GET /payment_methods/new
  # GET /payment_methods/new.xml
  def new
    @payment_method = PaymentMethod.new
    render partial: 'new', content_type: 'text/html'
  end

  # GET /payment_methods/1/edit
  def edit
    @payment_method = PaymentMethod.find(params[:id])
    render partial: 'edit', content_type: 'text/html'
  end

  # POST /payment_methods
  # POST /payment_methods.xml
  def create
    @payment_method = PaymentMethod.new(params[:payment_method])

    if @payment_method.save
      js_notify message: t('admin.payment_methods.create.success'), type: 'alert-success', time: 2500
      render partial: 'payment_method', content_type: 'text/html', locals: { payment_method: @payment_method }
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  # PUT /payment_methods/1
  # PUT /payment_methods/1.xml
  def update
    @payment_method = PaymentMethod.find(params[:id])

    if @payment_method.update_attributes(params[:payment_method])
      js_notify message: t('admin.payment_methods.update.success'), type: 'alert-success', time: 2500
      render partial: 'payment_method', content_type: 'text/html', locals: { payment_method: @payment_method }
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  end

  # DELETE /payment_methods/1
  # DELETE /payment_methods/1.xml
  def destroy
    @payment_method = PaymentMethod.find(params[:id])
    if @payment_method.destroy
      js_notify message: t('admin.payment_methods.destroy.success'), type: 'alert-error', time: 2500
      render nothing: true, content_type: 'text/html'
    else
      message = "#{t('admin.payment_methods.destroy.error')}: #{@payment_method.errors[:base].first}"
      js_notify message: message, type: 'alert-info', time: 2500
      render nothing: true
    end
  end
end
