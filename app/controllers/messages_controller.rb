class MessagesController < ApplicationController
  def create
    message = JSON.parse(request.body.read)['message']
    convo_id = message['convo_id']
    to_user = message['to_user']
    from_user = session[:user_id]
    content = message['message_content']
    @message = Message.create(conversation_id: convo_id, sender_id_fk: from_user, receiver_id_fk: to_user, message_content: content)

    MessagesChannel.broadcast_to(
      convo_id,
      receiver_id_fk: to_user,
      sender_id_fk: from_user,
      message_content: content,
      created_at: @message.created_at
    )
  end
end
