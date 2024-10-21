class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_blog_post, only: %i[show edit update destroy]
  def index
    @blog_posts = BlogPost.all
  end
  def show
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def new
    if user_signed_in?
    @blog_post = BlogPost.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

   private
  def blog_post_params
     params.require(:blog_post).permit(:title, :body)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
  def authenticate_user!
    redirect_to new_user_session_path, alert: " You need to sign in or sign up before continuing." unless user_signed_in?
  end
end