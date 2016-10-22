class Message < ApplicationRecord
	belongs_to :sender, :class_name => "User"

	has_many :recipients, dependent: :destroy

	validates :content, presence: true
end
