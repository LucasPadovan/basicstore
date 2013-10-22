module NavHelper
  def store_urls(product_type)
    #todo: cuando este en store_path sin ningun parametro deberia marcar las novedades como pestaña porque es la sección a la que se accede
    urls = [store_index_path(product_type: product_type.name)]
    #if product_type.name == 'Novedades'
    #  urls << store_index_path
    #end
    urls
  end
end
