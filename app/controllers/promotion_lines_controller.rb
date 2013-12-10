class PromotionLinesController < ApplicationController
  before_filter :get_promotion

  def new
    @promotion_line = @promotion.promotion_lines.build
    render partial: 'new', content_type: 'text/html'
  end

  def create
    @promotion_line = @promotion.promotion_lines.build(params[:promotion_line])

    if @promotion_line.save!
      render partial: 'promotion_lines/promotion_line', locals: { promotion_line: @promotion_line }, content_type: 'text/html'
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  def edit

  end

  def update

  end

  def destroy
    @promotion_line = PromotionLine.find(params[:id])
    if @promotion_line.destroy
      render nothing: true, content_type: 'text/html'
    else
      js_notify 'No se pudo eliminar, intente nuevamente.'
    end
  end

  private
  def get_promotion
    @promotion = Promotion.find(params[:promotion_id])
  end
end