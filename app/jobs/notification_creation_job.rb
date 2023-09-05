class NotificationCreationJob < ApplicationJob
  queue_as :default

  def perform(message_id, recipient_ids)
    message = Message.find(message_id)
    current_user = message.user

    recipient_ids.each do |recipient_id|
      recipient = User.find(recipient_id)
      Notification.create(recipient: recipient, actor: current_user, action: "messaged", notifiable: message)
    end
  end
end
