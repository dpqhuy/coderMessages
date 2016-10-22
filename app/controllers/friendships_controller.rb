class FriendshipsController < ApplicationController
	before_action :require_login, only: [:create]
  def create
	@friend = User.find_by_id(params[:friend_id])

  	@friendship = Friendship.new
  	@friendship.user = current_user
  	@friendship.friend = @friend
  	@friendship.status = "accepted"
  	if @friendship.save
  		flash[:success] = "#{@friend.name} is now your friend." 
  	else
  		flash[:error] = "#{@friendship.errors.full_messages.to_sentence}" 
  	end
  	redirect_to users_path
  end

private
	def friendship_params
		params.require(:friendship).permit(:friend_id)
	end
end
