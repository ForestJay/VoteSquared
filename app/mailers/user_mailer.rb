# Class for sending mail to users.
class UserMailer < ActionMailer::Base
  default from: "no-reply@VoteSquared.org"
  
  def welcome_email(user)
    @user = user
    @url  = 'http://VoteSquared.org/'
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Welcome to VoteSquared.org')
  end
  
  def watched_politician_update(politician, user)
    @user = user
    @url  = 'http://VoteSquared.org/'
    @politician = politician
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "Vote Squared Update: #{politician.full_name}")
  end
  
  def watched_politician_new_rating(politician, voter_rating, user)
    @user = user
    @url  = 'http://VoteSquared.org/'
    @politician = politician
    @voter_rating = voter_rating
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "Vote Squared Update: New Rating for #{politician.full_name}")
  end
end
