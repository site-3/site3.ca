class Admin::MemberApplicationsController < ApplicationController
  before_action :verify_admin_member

  def index
    @member_applications = MemberApplication.all
  end

  def approve
    ActiveRecord::Base.transaction do
      @member_application = MemberApplication.find(params[:member_application_id])
      @member = Member.create_from_member_application(@member_application)

      @member.save!
      @member_application.update!(member: @member)
    end

    redirect_to admin_member_applications_path
  end
end
