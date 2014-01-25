class Admin::PromotionLinesController < Admin::AdminController
  before_filter :get_promotion

  def new
    @promotion_line = @promotion.promotion_lines.build
    render partial: 'new', content_type: 'text/html'
  end

  def create
    @promotion_line = @promotion.promotion_lines.build(params[:promotion_line])

    if @promotion_line.save!
      total = @promotion.total + @promotion_line.total
      @promotion.update_attributes(total: total)
      js_notify message: t('admin.promotion_lines.create.success'), type: 'alert-success'
      render partial: 'admin/promotion_lines/promotion_line', locals: { promotion_line: @promotion_line }, content_type: 'text/html'
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @promotion_line = PromotionLine.find(params[:id])
    if @promotion_line.destroy
      @promotion_line.promotion.total -= @promotion_line.total
      @promotion_line.promotion.save
      js_notify message: t('admin.promotion_lines.destroy.success'), type: 'alert-danger'
      render nothing: true, content_type: 'text/html'
    else
      js_notify message: t('admin.promotion_lines.destroy.error')
    end
  end

  private
  def get_promotion
    @promotion = Promotion.find(params[:promotion_id])
  end
end