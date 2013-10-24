class PromotionLinesController < ApplicationController
  before_filter :get_promotion

  def new
    @promotion_line = @promotion.promotion_lines.build
    render partial: 'choose_product', content_type: 'text/html'
  end

  def create

  end

  def edit

  end

  def update

  end

  def delete

  end

  private
  def get_promotion
    @promotion = Promotion.find(params[:promotion_id])
  end
end