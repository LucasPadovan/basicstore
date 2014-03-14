var
    cartOpen = false
    , timeOpen = 0;

var toggleFloatingCart = function(){
    var
        cart = $('[data-element="floating-cart"]')
        , $button = $('[data-action="toggle-cart"]')

    if(cartOpen) {
        changeCartTooltip('Abrir el carrito')
        closeCart(cart)
        $button.tooltip('hide')
    }
    else {
        changeCartTooltip('Cerrar el carrito')
        $button.tooltip('show')
        openCart(cart)
    }
}

var closeCart= function(cart){
    if(cartOpen) {
        $(cart).css('left', '-290px')
        cartOpen = false;
    }
}

var openCart = function(cart){
    if(cartOpen == false) {
        $(cart).css('left', '-10px')
        cartOpen = true
    }
}

var changeCartTooltip = function(new_title){
    $('[data-action="toggle-cart"]').attr('data-original-title', new_title)
}

var changeTargetForButton = function(target, type){
    var
        element = '#add_' + type + '_' + target
        , new_id = 'add_' + type + '_' + target
        , new_target = 'line_' + type + '_' + target
        , new_button = '<a href="/line_items?' + type + '_id=' + target + '" class="btn btn-warning add-to-cart-fill stitched" data-callback="updateCart(' + target + ', \'' + type + '\')" data-error="' + new_target + '" data-method="post" data-remote="true" data-replace="true" data-respond-as="put" data-target="' + new_target + '" id="' + new_id + '" rel="nofollow">Añadir al Carrito</a>'
    $(element).replaceWith(new_button)
}

var updateCart = function(target, type){
    changeTargetForButton(target, type)
    updateCartTotal()
    animatePurchase(target, type)
}

var updateCartTotal = function(){
    var
        total = 0
        , elements = $('[data-type="price"]')
        , cart_total = $('[data-type="cart-total"]')[0]
    $.each(elements, function( index, value ) {
        total += parseFloat(value.innerHTML)
    })
    cart_total.innerHTML = total
}

var animatePurchase = function(target, type){
    highlightItem(target, type)
    openCart($('[data-element="floating-cart"]'))
    timeOpen = +new Date
    setTimeout(function(){
        var timeElapsed = +new Date - timeOpen
        if(cartOpen && ( timeElapsed > 1400))
            closeCart($('[data-element="floating-cart"]'))
    }, 1500)

}

var highlightItem = function(target, type){
    $('#line_' + type + '_' + target).hide().toggle('highlight', 'slow')
}
