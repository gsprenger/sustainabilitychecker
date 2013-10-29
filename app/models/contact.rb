class Contact < MailForm::Base
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "[Sustainability Checker] New e-mail from user!",
      :to => "gabriel.sprenger@gmail.com",
      :from => %(Sustainability Checker <notifications@sustainabilitychecker.com>)
    }
  end
end