class MailsController < ApplicationController
	def index
		@mails = Vmail.all
	end

	def new
		@mail = Vmail.new
	end

	def create
		mail = Vmail.new
		mail.subject = params["vmail"]["subject"]
		mail.body = params["vmail"]["body"]
		mail.save!
		redirect_to :action => "index"
	end
end
