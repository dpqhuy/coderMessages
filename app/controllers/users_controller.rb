class UsersController < ApplicationController
	before_action :require_login, only: [:index]
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "Sign Up Successfully!"
  		session[:user_id] = @user.id
  		redirect_to users_path
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
