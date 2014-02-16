class Admin::OrdersController < Admin::AdminController

  def index
    @title = t('orders.index.title')
    set_date_filter
    @state =  params[:filter][:state] if params[:filter] && params[:filter][:state].present?

    @orders = Order.includes(:estadordens).where(created_at: [@start_date..@end_date])
    @orders = @orders.select { |x| x if x.last_state.estado == @state } if @state
    @orders = @orders.paginate(page: params[:page], order: 'orders.created_at desc', per_page: 10)

    respond_to do |format|
      format.html
    end

  end

  def show
    @order = Order.find(params[:id])
    @title = t('orders.show.title', number: @order.number)
    set_page_meta_tags @title, nil
    #todo: enviar a metodo en el modelo de la orden
    unless @order.estadordens.count > 1
      @estado = Estadorden.create(user_id: session[:user_id], order_id: @order.id, estado: 'Leido') if session[:user_id].present?
    end

    respond_to do |format|
      format.html
    end
  end

  def destroy
    @order = Order.find(params[:id])
    #todo: destroy logico
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(admin_orders_url) }
    end
  end

end
