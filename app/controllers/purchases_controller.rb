class PurchasesController < ApplicationController
  def index
  end

  def create
    # Amount in cents
    @price = 500

    charge = Stripe::Charge.create(
      :customer    => "cus_5qHyRFvmydfit6",
      :amount      => @price,
      :description => 'Vending machine refreshment',
      :currency    => 'cad'
    )

    flash[:notice] = "Charge successful"
    redirect_to purchases_path

  rescue Exception => e
    flash[:alert] = e.message
    redirect_to purchases_path
  end
end
