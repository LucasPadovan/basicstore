module NavHelper
  def store_urls(product_type)
    urls = [store_index_path(product_type: product_type.name)]
    #if product_type.name == 'Novedades'
    #  urls << store_index_path
    #end
    urls
  end
end
