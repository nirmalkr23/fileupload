class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status

  def index
    @room = Room.new
    @current_user = current_user
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)
  
  end

  
  def show
    
    @current_user = current_user
    @single_room = Room.find(params[:id])
    @message = Message.new
    @messages = @single_room.messages
    mark_notifications_as_read
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
  
    render "index"
    
  end

  def create
    @room = Room.create(name: params["room"]["name"])
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    redirect_to rooms_path, notice: 'Room was successfully destroyed.'
    # Add any necessary redirect or rendering logic here
  end

  def mark_notifications_as_read
    notification_to_mark_as_read = @single_room.notifications_as_room.where(recipient: current_user)
    notification_to_mark_as_read.update_all(read_at: Time.zone.now)
  end

  def set_status
    current_user.update!(status: User.statuses[:online]) if current_user
  end

end
