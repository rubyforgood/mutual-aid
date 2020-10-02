class ApplicationMailer < ActionMailer::Base
  default from: "#{ENV["SMTP_FROM_EMAIL"]}"
  layout 'mailer'
end
