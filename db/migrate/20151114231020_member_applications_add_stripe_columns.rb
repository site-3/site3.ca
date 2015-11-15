class MemberApplicationsAddStripeColumns < ActiveRecord::Migration
  def change
    add_column :member_applications, :stripe_payment_token, :text, null: false, default: ""
    add_column :member_applications, :stripe_id, :text, null: false, default: ""
    add_column :member_applications, :enable_vending_machine, :boolean, null: false, default: false
  end
end
