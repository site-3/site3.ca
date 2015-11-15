class MemberMailer < ApplicationMailer
  def welcome_email(member)
    @member = member
    mail(to: @member.email, subject: 'Welcome to Site 3!')
  end
end
