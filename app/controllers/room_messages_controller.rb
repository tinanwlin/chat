class RoomMessagesController < ApplicationController
  before_action :load_entities
  
  def create
    @room_message = RoomMessage.new(user: current_user, room: @room, message: params.dig(:room_message, :message))
    respond_to do |format|
      if @room_message.save
        format.html { redirect_to room_path(@room) }
        format.json { render :@room_message.json }
      else
        format.json { render json: @room_message.errors, status: :unprocessable_entity }
      end
    end

    RoomChannel.broadcast_to @room, @room_message

  end

  protected

  def load_entities
    @room = Room.find(params.dig(:room_message, :room_id))
  end
  
end
