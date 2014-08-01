class ContactMailer < ActionMailer::Base
  default from: "notifications@thesustainabilitysudoku.info"

  def send_contact_email(name, text, email)
    @name = name
    @text = text
    if email != ''
      @email = email
    else 
      @email = false
    end
    mail(:to => 'thesustainabilitysudoku@gmail.com', :subject => 'New message from the contact form!')
  end
end
