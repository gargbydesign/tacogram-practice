class CommentsController < ApplicationController
  def create
    @comment = Comment.new
    @comment["body"] = params["body"]
    @comment["user_id"] = @current_user["id"]
    @comment["post_id"] = params["post_id"]
    @comment.save
    redirect_to "/posts/#{params["post_id"]}"
  end

  def destroy
    @comment = Comment.find_by({"id" => params["id"]})
    post_id = @comment["post_id"]
    @comment.destroy
    redirect_to "/posts/#{post_id}"
  end
end
