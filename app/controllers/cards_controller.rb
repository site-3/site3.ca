class CardsController < ApplicationController
  before_action :authenticate_member!
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    card_token = params[:id]

    current_member.stripe_customer.sources.create(source: card_token)
  rescue Exception => e
    # This trusts that Stripe won't return any errors with sensitive data
    flash[:alert] = e.message

    redirect_to edit_registration_path
  end
end
