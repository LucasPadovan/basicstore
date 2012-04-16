class SessionController < ApplicationController
  skip_before_filter :authorize
  
  def new
  end

  def create
#    Intenta que el primer usuario que se intenta loguear se cree con privilegios de admin
#    if User.count.zero?
#      user = User.authenticate(params[:name],params[:password])
#      session[:user_id] = user.id
#      redirect_to admin_url
#    end

    if user = User.authenticate(params[:name],params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id]=nil
    redirect_to store_url, :notice => "Logged out"
  end

end
