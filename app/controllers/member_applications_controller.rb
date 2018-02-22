class MemberApplicationsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  after_action :send_member_application_email, only: :create

  def new
    @member_application = MemberApplication.new
  end

  def create
    @member_application = MemberApplication.new(member_application_params)

    if @member_application.create_stripe_customer?
      @member_application.create_stripe_customer
    end

    respond_to do |format|
      format.json do
        if @member_application.save
          render json: {success: true}
        else
          render json: {
            success: false,
            errors: @member_application.errors,
          }, status: 522
        end
      end
      format.html do
        if @member_application.save
          # TODO show success
          redirect_to after_create_path
        else
          render :new
        end
      end
    end
  end

private
  def member_application_params
    params.require(:member_application).permit(:name, :email, :rfid, :stripe_payment_token, :vending_machine_enabled)
  end

  def after_create_path
    root_path
  end

  def send_member_application_email
    if @member_application.valid?
      MemberApplicationMailer.application_submitted(@member_application).deliver_now
    end
  end
end
