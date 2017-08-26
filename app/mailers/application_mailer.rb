class ApplicationMailer < ActionMailer::Base
  default from: ENV['APP_SENDER_EMAIL:']
  layout 'mailer'
end
