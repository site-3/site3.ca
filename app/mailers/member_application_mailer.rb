class MemberApplicationMailer < ApplicationMailer
  def application_submitted(member_application)
    @member_application = member_application
    mail(to: @member_application.email, subject: t('email_titles.membership_application_created'))
  end
end
