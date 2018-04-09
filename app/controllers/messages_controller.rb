class MessagesController < ApplicationController
  #before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    msg = message_params["body"] 
    arr = msg.split(" ").map(&:downcase)
    mail_entities = ["send", "email", "compose", "mail"]
    response = {}
    if (arr - mail_entities).count != arr.count
      mails = Vmail.all.map(&:subject)
      subject = ""
      mails.each do |m| subject = m if msg.include?(m) end
      #need to send mail to user
      if msg.include? "to"
        user_name = msg.partition('email to').last.strip.split(" ").first
        user = User.find_by_name user_name
        if user.present?
          SystemMailer.send_mail(user, subject).deliver_now
          response = {"body" => "Sent successfully !!!", :user_id => User.find_by_name("RZ").id}
        else
          if msg.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i).present?
            email = msg.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i).first
            SystemMailer.send_test_mail(email, subject).deliver_now
            response = {"body" => "Sent successfully !!!", :user_id => User.find_by_name("RZ").id}
          else
            response = {"body" => "Unable to find user, Please enter email id", :user_id => User.find_by_name("RZ").id}
          end
        end
      end
    else
      reaction = CHATBOT.get_reaction(message_params["body"])
      if reaction.blank?
        client = ApiAiRuby::Client.new(
          :client_access_token => '8b0d6ed53fa846c9836f94b9a13bf150'
        )
        response = client.text_request message_params["body"]
        if response[:result][:action] == "input.unknown"
          #need to handle database queries
          tables = ActiveRecord::Base.connection.tables
          if (tables - arr).count != tables.count
            tabel_name = tables & s.downcase.split(" ").first
          else
            SystemMailer.send_mail_to_owner(msg).deliver_now
            response = {"body" => "Sorry, I dont know what you have asked just now.. I am still learning.. I will update myself and get back to you soon !!! :p :p", :user_id => User.find_by_name("RZ").id}
          end
        else
          res = response[:result][:fulfillment][:speech]
          response = {"body" => res, :user_id => User.find_by_name("RZ").id}
        end
      else
        response = {"body" => reaction, :user_id => User.find_by_name("RZ").id}
      end
    end
    @response = @conversation.messages.build(response)
    @response.save!
    @message.user_id = current_user.id
    @message.save!

    @path = conversation_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
  def handle_mail
    
  end
end
