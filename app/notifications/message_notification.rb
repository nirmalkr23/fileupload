# To deliver this notification:
#
# MessageNotification.with(post: @post).deliver_later(current_user)
# MessageNotification.with(post: @post).deliver(current_user)

class MessageNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  #param :message

  # Define helper methods to make rendering easier.
  #

  def message
    @room=Room.find(params[:message][:room_id])
    @message=Message.find(params[:message][:id])
    @user=User.find(@message.user_id)
    "#{@user.first_name} sent a msg => #{@message.content.truncate(10)}"
  end
  #
  def url
    #user=params[:recp]
    user=User.find(params[:message][:user_id])
    if user.present?
      
      message_url = user_path(user)
      return message_url
    else
      # Handle the case where room_id or message_id is missing
      # You can return a fallback URL or handle it as needed
      return nil
    end

    
  end
end
