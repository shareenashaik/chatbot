class SystemMailer < ApplicationMailer
	default :from => "notifications@example.com"

	def send_mail(user)
		@user = user
		@url  = "http://example.com/login"
		mail(:to => user.email, :subject => "Sample Mail")
	end
	def send_test_mail(email)
		@email = email
		@url  = "http://example.com/login"
		mail(:to => email, :subject => "Sample Mail")
	end
end
