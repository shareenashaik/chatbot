class ConversationsController < ApplicationController
  #before_filter :authenticate_user!

  layout false
  skip_before_filter :verify_authenticity_token  


  def create
    params[:recipient_id] = User.last.id
    params[:sender_id] = User.first.id
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    render json: { conversation_id: @conversation.id }
  end

  def show
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    user = User.find_by_name "RZ"
    @messages = [Message.new(:body => "Greetings, humans. My name is VL Bot", :created_at => Time.now, :user_id => user.id, :conversation_id => 1)]#@conversation.messages
    @message = Message.new
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end