var toggleFloatingCart = function(){
    var
        cart = $('[data-element="floating-cart"]')
        , $button = $('[data-action="toggle-cart"]')

    if($(cart).css('left') == '-10px') {
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

var  closeCart= function(cart){
    $(cart).css('left', '-290px')
}

var openCart = function(cart){
    $(cart).css('left', '-10px')
}

var changeCartTooltip = function(new_title){
    $('[data-action="toggle-cart"]').attr('data-original-title', new_title)
}

var changeTargetForButton = function(target){
    var
        element = '#add_product_' + target
        , new_id = 'add_product_' + target
        , new_target = 'line_product_' + target
        , new_button = '<a href="/es/line_items?product_id=' + target + '" class="btn btn-warning add-to-cart-fill" data-callback="updateCart(' + target + ')" data-error="' + new_target + '" data-method="post" data-remote="true" data-replace="true" data-respond-as="put" data-target="' + new_target + '" id="' + new_id + '" rel="nofollow">Añadir al Carrito</a>'
    $(element).replaceWith(new_button)
}

var updateCart = function(target){
    changeTargetForButton(target)
    updateCartTotal()
    animatePurchase(target)
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

var animatePurchase = function(target){
    toggleFloatingCart()
    highlightItem(target)
    setTimeout(function(){
        toggleFloatingCart()
    }, 1500)
}

var highlightItem = function(target){
    $('#line_product_' + target).hide().toggle('highlight', 'slow')
}

//todo: usar variable de entorno para saber si el carro esta abierto o cerrado.
