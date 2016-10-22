class UsersController < ApplicationController
	before_action :require_login, only: [:index]

  def index

  	@current_user = current_user
  	@users = User.all.to_a.reject do |user|
  		user == current_user or @current_user.friends.include?(user) or @current_user.inverse_friends.include?(user)
  	end
  end

  def new
  	if signed_in?
  		redirect_to messages_path
  	end
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "Sign Up Successfully!"
  		session[:user_id] = @user.id
  		redirect_to messages_path
  	else
  		flash[:error] = "#{@user.errors.full_messages.to_sentence}"
  		redirect_to new_user_path
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

end
