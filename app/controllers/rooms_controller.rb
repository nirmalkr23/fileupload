class RoomsController < ApplicationController
  
  def index
    @room = Room.new
    @current_user = current_user
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)
  end

  def show
    @message = Message.new
    
    
    @current_user = current_user
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @messages = @single_room.messages
    render "index"
  end

  def create
    @room = Room.create(name: params["room"]["name"])
  end
end
