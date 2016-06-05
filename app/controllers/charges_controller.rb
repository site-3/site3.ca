class ChargesController < ApplicationController
  before_action :authenticate_member!, only: [:index]
  skip_before_filter :verify_authenticity_token, only: [:create]

  def index
    @last_charge = params[:last_charge]

    @charges = Stripe::Charge.all(
      customer: current_member.stripe_id,
      limit: charges_per_page,
      starting_after: @last_charge.presence
    )
  rescue Exception => e
    # TODO make sure that displaying e.message isn't a security risk
    flash[:alert] = e.message
  end

  # Create a vending machine purchase by looking up the member by rfid.
  # The member must have `enable_vending_machine` to be able to make the purchase.
  # This method always responds in json and when it is not successful it does NOT
  # explain why.
  def create
    token = params[:token]
    raise "No vending_machine_token secret"  if Rails.application.secrets.vending_machine_token.nil?
    raise "Incorrect token"  unless Devise.secure_compare(token, Rails.application.secrets.vending_machine_token)

    rfid = params[:rfid].downcase
    @member = Member.where(rfid: rfid, enable_vending_machine: true).first!

    # Amount in cents, we set this not the vending machine
    @price = 500

    Stripe::Charge.create(
      customer: @member.stripe_id,
      amount: @price,
      description: 'Vending machine refreshment',
      currency: 'cad'
    )

    render json: {status: 0}
  rescue Exception => e
    render json: {status: 1}
  end

private
  def charges_per_page
    100
  end
end
