module NavHelper
  def store_urls(product_type)
    #todo: cuando este en store_path sin ningun parametro deberia marcar las novedades como pestaña porque es la sección a la que se accede
    urls = []
    urls << store_index_path(product_type: product_type.name)
    urls
  end

  def product_urls
    urls = [store_index_path]
    urls << @product if @product
    urls
  end

  def cart_urls
    urls = []
    urls << @cart if @cart
    urls
  end
end
