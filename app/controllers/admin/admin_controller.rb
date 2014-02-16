class Admin::AdminController < ApplicationController
  before_filter :authorize
  skip_before_filter :set_i18n_locale_from_params

  layout 'admin'

  def set_date_filter
    @start_date = ( params[:filter] && params[:filter][:start_date].present? ? params[:filter][:start_date].to_datetime : ( Date.today - 1.months ) )
    @end_date = ( params[:filter] && params[:filter][:end_date].present? ? params[:filter][:end_date].to_datetime : Date.today )
  end

  protected
  def authorize
    unless User.find(session[:user_id])
      redirect_to login_url, notice: 'Por favor ingrese al sistema'
    end
  end
end
