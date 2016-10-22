class MessagesController < ApplicationController
  def index
  	@messages = Message.includes(:recipients).where('recipients.receiver_id = ?', current_user.id).references(:recipients).order("messages.created_at DESC")
  end

  def sent
  	@messages = Message.where(:sender_id => current_user.id).order("created_at DESC").reject do |message|
  		message.recipients.try(:receiver) != nil 
  	end
  end

  def show
  	@recipient = Message.find(params[:id]).recipients.find_by_receiver_id(current_user.id)
  	if @recipient
  		if @recipient.status != "read"
	  		@message = Message.find(params[:id])
	  		@recipient.update_attribute(:status, "read")
	  	else
	  		flash[:notice] = "The message has already been read."
	  	end
  	else
  		flash[:notice] = "You are not in the recipient list of this message."
  	end
  end

  def create
  	if params[:receiver_ids].nil?
  		redirect_to new_message_path 
  		flash[:error]  = "No Receiver Selected"
  		return
  	end
  	@message = Message.new
	@message.sender = current_user
	@message.content = params[:content]

	if (@message.save)
		params[:receiver_ids].each do |receiver_id|
  			Recipient.create(:message_id => @message.id, :receiver_id => receiver_id)
  		end
  		redirect_to messages_path
  	else
  		redirect_to new_message_path
  		flash[:error] = "You can not send empty message"
	end
  end

  private
  	def message_params
  		params.require(:message).premit(:content, receiver_ids: [])
  	end
end
