class PostsController < ApplicationController
  before_action :authenticate_user, only: ["new", "create"]

  def index
    @posts = Post.all
    if @current_user == nil
      flash["notice"] = "You must be logged in to create a post."
    end
  end

  def show
    @post = Post.find_by({"id" => params["id"]})
    @comments = Comment.where({"post_id" => @post["id"]})
  end

  def new
  end
  
  def authenticate_user
    if @current_user == nil
      flash["notice"] = "You must be logged in to create a post."
      redirect_to "/login"
    end
  end

  def create
    @post = Post.new
    @post["body"] = params["body"]
    @post["image"] = params["image"]
    @post["user_id"] = @current_user["id"]
    @post.save
    redirect_to "/posts"
  end
end
