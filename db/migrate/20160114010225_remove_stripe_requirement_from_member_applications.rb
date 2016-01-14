class RemoveStripeRequirementFromMemberApplications < ActiveRecord::Migration
  def change
    change_column :member_applications, :stripe_id, :string, null: true, default: nil
    change_column :member_applications, :stripe_payment_token, :string, null: true, default: nil
  end
end
