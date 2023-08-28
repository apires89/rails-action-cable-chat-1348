class MessagesController < ApplicationController
  def create
    #what do we need?
    #find the chatroom using the :chatroom_id
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    #associate the message with the user and chatroom
    @message.user = current_user
    @message.chatroom = @chatroom
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
      #redirect_to chatroom_path(@chatroom)
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end


end
