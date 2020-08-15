class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def test
    mail(to: "savvyjesse@aol.com", subject: "a test email")
  end
end
