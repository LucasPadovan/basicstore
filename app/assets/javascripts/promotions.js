var updatePromotionTotal = function() {
    var
        promotion_line_totals = $('[data-promotion-line-total]')
        , $promotion_total = $('[data-promotion-total]')
        , new_total = 0

    for(var i = 0, length = promotion_line_totals.length; i < length; i++){
        new_total += parseFloat( promotion_line_totals[i].innerHTML );
    }
    $promotion_total.text(new_total)
}