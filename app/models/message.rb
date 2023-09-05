class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  

  after_create_commit { broadcast_append_to self.room }

  before_create :confirm_participant

  
def confirm_participant
  if self.room.is_private
    is_participant = Participant.where(user_id: self.user.id, room_id: self.room.id).first
    throw :abort unless is_participant
  end
end

after_create_commit :notify_user
before_destroy :cleanup_notifications
has_noticed_notifications model_name: 'Notification'

  private

  def notify_user
    recipients = room.participants.where.not(user_id: user)
    
    recipients.each do |u|
      user=u.user
    
      MessageNotification.with(message: self,room: room).deliver_later(user)
    end
  end

  def cleanup_notifications
    notifications_as_message.destroy_all
  end
end
