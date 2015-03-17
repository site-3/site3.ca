class PurchasesController < ApplicationController
  before_action :authenticate_member!, only: [:index]

  # TODO make sure that displaying e.message isn't a security risk

  def index
    @charges = Stripe::Charge.all(customer: current_member.stripe_id)
  rescue Exception => e
    flash[:alert] = e.message
  end

  # Create a vending machine purchase by looking up the member by rfid.
  # The member must have `enable_vending_machine` to be able to make the purchase.
  # This method always responds in json and when it is not successful it does NOT
  # explain why.
  def create
    token = params[:token]
    raise "No vending_machine_token secret"  if Rails.application.secrets.vending_machine_token.nil?
    raise "Incorrect token"  unless token == Rails.application.secrets.vending_machine_token

    rfid = params[:rfid]
    @member = Member.where(rfid: rfid, enable_vending_machine: true).first!

    # Amount in cents, we set this not the vending machine
    @price = 500

    Stripe::Charge.create(
      :customer    => @member.stripe_id,
      :amount      => @price,
      :description => 'Vending machine refreshment',
      :currency    => 'cad'
    )

    render json: {status: 0}
  rescue Exception => e
    render json: {status: 1}
  end
end
