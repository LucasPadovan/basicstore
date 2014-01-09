class ProductTypesController < ApplicationController
  # GET /product_types
  # GET /product_types.json
  def index
    q = "%#{params[:q]}%"
    @product_types = ProductType.where('lower(name) LIKE :query', query: q)
    respond_to do |format|
      format.html
      format.json { render json: @product_types.map(&:attributes) }
    end
  end

  # GET /product_types/1
  # GET /product_types/1.json
  def show
    @product_type = ProductType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_type }
    end
  end

  # GET /product_types/new
  # GET /product_types/new.json
  def new
    @product_type = ProductType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_type }
    end
  end

  # GET /product_types/1/edit
  def edit
    @product_type = ProductType.find(params[:id])
  end

  # POST /product_types
  # POST /product_types.json
  def create
    @product_type = ProductType.new(params[:product_type])

    respond_to do |format|
      if @product_type.save
        format.html { redirect_to @product_type, notice: 'Product type was successfully created.' }
        format.json { render json: @product_type, status: :created, location: @product_type }
      else
        format.html { render action: "new" }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_types/1
  # PUT /product_types/1.json
  def update
    @product_type = ProductType.find(params[:id])

    respond_to do |format|
      if @product_type.update_attributes(params[:product_type])
        format.html { redirect_to @product_type, notice: 'Product type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_types/1
  # DELETE /product_types/1.json
  def destroy
    unless params[:id] == 1
      @product_type = ProductType.find(params[:id])
      @product_type.destroy
    end

    respond_to do |format|
      format.html { redirect_to product_types_url }
      format.json { head :ok }
    end
  end
end
