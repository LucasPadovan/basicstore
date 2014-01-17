class UsersController < ApplicationController
  skip_before_filter :authorize
#  saltar la autorizacion solo si no hay usuarios en la base de datos
  # GET /users
  # GET /users.xml
  def index
    @title = t('users.index.title')
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
    @title = t('users.show.title', name: @user.name)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @title = t('users.new.title')
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @title = t('users.edit.title')
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @title = t('users.new.title')
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_url, :notice => "User #{@user.name} was successfully created.") }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @title = t('users.edit.title')
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_url, :notice => "User #{@user.name} was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "user #{@user.name} deleted"
    rescue Exception => e
      flash[:notice]= e.message
    end

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
