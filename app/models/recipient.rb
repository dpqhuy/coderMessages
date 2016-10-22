class Recipient < ApplicationRecord
  belongs_to :message
  belongs_to :receiver, :class_name => "User"

  validate :message_present
  validate :receiver_present

  private
	  def message_present
	    if message.nil?
	      errors.add(:message, "is not valid.")
	    end
	  end

	  def receiver_present
	    if receiver.nil?
	      errors.add(:receiver, "is not a valid receiver.")
	    end
	  end
end
