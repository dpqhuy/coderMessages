class SessionsController < ApplicationController
  before_action :skip_if_logged_in, only: [:create, :new]
  def create
   if @user = User.find_by(email: params[:email])
     if @user.authenticate(params[:password])
       flash['success'] = "login successful"
       session[:user_id] = @user.id
       redirect_to messages_path
     else
       flash['error'] = "login invalid"
       redirect_to new_session_path
     end
   else
     flash['error'] = "User not found"
     redirect_to new_session_path
   end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: "Logged out."
  end
end
