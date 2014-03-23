class ProductsController < ApplicationController
  before_filter :set_current_cart, only: :show
  skip_before_filter :authorize, only: :show

  def show
    @product = Product.find(params[:id])
    @related_promotions = Promotion.includes(:promotion_lines).where('promotion_lines.product_id = ?', @product.id)

    @products_in_cart = @cart.line_items.map(&:product_id)
    @promotions_in_cart = @cart.line_items.map(&:promotion_id)

    @title = @product.titulo

    set_page_meta_tags @title, @product.descripcion

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end
end
