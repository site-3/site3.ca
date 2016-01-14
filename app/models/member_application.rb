#
# A MemberApplication holds information we ask for from perspective members
# not all Members will fill in a MemberApplication.
#

class MemberApplication < ActiveRecord::Base
  has_paper_trail

  belongs_to :member

  validates :name, presence: true
  validates :email, presence: true # TODO validate format

  def approved?
    member.present?
  end

  def create_stripe_customer?
    stripe_id.nil? && stripe_payment_token.present?
  end

  def create_stripe_customer
    stripe_customer = Stripe::Customer.create(
      email: email,
      description: name,
      source: stripe_payment_token,
    )

    stripe_id = stripe_customer.id
  end
end
