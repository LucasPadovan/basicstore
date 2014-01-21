class Admin::UsersController < Admin::AdminController
  skip_before_filter :authorize
#  saltar la autorizacion solo si no hay usuarios en la base de datos
  # GET /users
  # GET /users.xml
  def index
    @title = t('admin.users.index.title')
    @users = User.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    render partial: 'show', content_type: 'text/html'
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @title = t('admin.users.new.title')
    @user = User.new

    render partial: 'new', content_type: 'text/html'
  end

  # GET /users/1/edit
  def edit
    @title = t('admin.users.edit.title')
    @user = User.find(params[:id])

    render partial: 'edit', content_type: 'text/html'
  end

  # POST /users
  # POST /users.xml
  def create
    @title = t('admin.users.new.title')
    @user = User.new(params[:user])

    if @user.save
      js_notify message: t('admin.users.create.success'), type: 'alert-success', time: 2500
      render partial: 'user', content_type: 'text/html', locals: { user: @user }
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @title = t('admin.users.edit.title')
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      js_notify message: t('admin.users.update.success'), type: 'alert-success', time: 2500
      render partial: 'user', content_type: 'text/html', locals: { user: @user }
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      js_notify message: t('admin.users.destroy.success'), type: 'alert-error', time: 2500
      render nothing: true, content_type: 'text/html'
    else
      message = "#{t('admin.users.destroy.error')}: #{@user.errors[:base].last}"
      js_notify message: message, type: 'alert-info', time: 2500
      render nothing: true
    end
  end
end
