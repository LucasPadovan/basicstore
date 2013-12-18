var toggleFloatingCart = function(){
    var cart = $('[data-element="floating-cart"]')

    if($(cart).css('left') == '-10px') {
        changeCartTooltip('Abrir el carrito')
        closeCart(cart)
    }
    else {
        changeCartTooltip('Cerrar el carrito')
        $('[data-action="toggle-cart"]').tooltip('show')
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
        element = '#add_' + target
        , new_target = 'line_' + target
    $(element).attr('data-replace', true)
    $(element).attr('data-target', new_target)
    $(element).attr('data-respond-as', 'put')
}

var updateCartTotal = function(){

}