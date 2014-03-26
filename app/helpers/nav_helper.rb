module NavHelper
  def store_urls(product_type)
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

  def admin_products_urls
    url = [admin_products_path]
    url << admin_product_path(@product) if @product
    url << admin_product_prices_path(@product) if @product && @prices
    url
  end
end
