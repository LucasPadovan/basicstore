class Admin::PostsController < Admin::AdminController
  # GET /posts
  # GET /posts.json
  def index
    @title = t('admin.posts.index.title')
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    render partial: 'show', content_type: 'text/html'
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = current_user.posts.build

    render partial: 'new', content_type: 'text/html'
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

    render partial: 'edit', content_type: 'text/html'
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(params[:post])

    if @post.save
      render partial: 'post', content_type: 'text/html', locals: { post: @post }
    else
      render partial: 'new', status: :unprocessable_entity
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      render partial: 'post', content_type: 'text/html', locals: { post: @post }
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    render nothing: true, content_type: 'text/html'
  end
end
