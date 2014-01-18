class Admin::AdminController < ApplicationController
  before_filter :authorize

  layout 'admin'

  protected
  def authorize
    unless User.find(session[:user_id])
      redirect_to login_url, notice: 'Por favor ingrese al sistema'
    end
  end
end
