class UserMailer < ActionMailer::Base
  default from: "notifier@employtown.com"

  def notify_signup(email)
    @email = email
    mail to: 'scott.balster@gmail.com', subject: 'A new user has signed up for EmployTown!'
  end
end
