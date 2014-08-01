class ContactMailer < ActionMailer::Base
  default from: "no-reply@thesustainabilitysudoku.info"

  def send_contact_email(name, text, email)
    @name = name
    @text = text
    if email != ''
      @email = email
    else 
      @email = false
    end
    mail(:to => 'thesustainabilitysudoku@gmail.com', :subject => 'New message from Contact Form!')
  end
end
