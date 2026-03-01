class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by({ "email" => params["email"] })

    if user == nil
      flash["notice"] = "No user found with that email."
      redirect_to "/login"
    elsif BCrypt::Password.new(user["password"]) == params["password"]
      session["user_id"] = user["id"]
      flash["notice"] = "Successfully logged in!"
      redirect_to "/posts"
    else
      flash["notice"] = "Incorrect password."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Logged out."
    redirect_to "/sessions/new"
  end
end
