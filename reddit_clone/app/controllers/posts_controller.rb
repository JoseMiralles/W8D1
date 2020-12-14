class PostsController < ApplicationController
  def new
  end

  def create
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if current_user.id != @post.author_id
      flash[:erros] = ["You are not the owner."]
      redirect_to posts_url(@post.id)
      return
    end

    if @post.update(post_params)
      redirect_to posts_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end
end
