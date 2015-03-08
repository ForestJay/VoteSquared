class UserMailer < ActionMailer::Base
  default from: "no-reply@VoteSquared.org"
  
  def welcome_email(user)
    @user = user
    @url  = 'http://VoteSquared.org/'
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Welcome to VoteSquared.org')
  end
end
