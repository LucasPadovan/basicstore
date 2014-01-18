class Admin::AdminController < ApplicationController
  before_filter :authorize
  before_filter :set_locale
  skip_before_filter :set_i18n_locale_from_params

  layout 'admin'

  protected
  def authorize
    unless User.find(session[:user_id])
      redirect_to login_url, notice: 'Por favor ingrese al sistema'
    end
  end

  def set_locale
    I18n.locale = :es
  end
end
