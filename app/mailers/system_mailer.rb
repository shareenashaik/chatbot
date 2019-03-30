class SystemMailer < ApplicationMailer
	default :from => "notifications@example.com"

	def send_mail(user, subject)
		@mail = Vmail.find_by_subject subject
		@user = user
		@url  = "http://example.com/login"
		subject = @mail.present? ? @mail.subject : "Sample Mail"
		attachments["csv_file.csv"] = File.read("#{Rails.root}/public/exported_csv.csv")
		mail(:to => user.email, :subject => subject)
	end
	def send_test_mail(email, subject)
		@mail = Vmail.find_by_subject subject
		@email = email
		@url  = "http://example.com/login"
		subject = @mail.present? ? @mail.subject : "Sample Mail"
		attachments["csv_file.csv"] = File.read("#{Rails.root}/public/exported_csv.csv")
		mail(:to => email, :subject => subject)
	end

	def send_mail_to_owner(msg)
		@msg = msg
		@email = "shaikshareena786@gmail.com"
		subject = "I was failed"
		mail(:to => @email, :subject => subject)
	end
end
