class MemberApplicationsController < ApplicationController
  def new
    @member_application = MemberApplication.new
  end

  def create
    @member_application = MemberApplication.new(member_application_params)

    if @member_application.valid?
      @member_application.save!
      # TODO show success
      redirect_to after_create_path
    else
      render :new
    end
  end

private
  def member_application_params
    params.require(:member_application).permit(:name, :email)
  end

  def after_create_path
    root_path
  end
end
