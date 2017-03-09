require 'csv'

#
# A Member is someone who has a subscription at Site 3 or had one in the past.
# Usually created by approving a MemberApplication.
#

class Member < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :oauth_identities
  has_one :member_application

  validates :name, presence: true
  validates :rfid, uniqueness: true

  scope :doorbot_enabled, -> { where(doorbot_enabled: true) }

  def rfid=(rfid)
    self[:rfid] = rfid&.downcase
  end

  def self.from_omniauth_identity(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.create_from_member_application(member_application)
    if member_application.create_stripe_customer?
      member_application.create_stripe_customer
      save!
    end

    create({
      doorbot_enabled: true,
      email: member_application.email,
      name: member_application.name,
      rfid: member_application.rfid,
      stripe_id: member_application.stripe_id,
      enable_vending_machine: member_application.enable_vending_machine,
      password: Devise.friendly_token[0,20],
    })
  end

  def to_csv_line
    CSV.generate_line(csv_fields, {row_sep: nil})
  end

  def to_builder
    Jbuilder.new do |member|
      member.(self, :email, :rfid)
    end
  end

  def stripe_customer
    Stripe::Customer.retrieve(stripe_id)
  end

  def stripe_dashboard_url
    "https://dashboard.stripe.com/customers/#{stripe_id}"
  end

  private

  def csv_fields
    membership_type = 'Associate'
    paid_until = nil
    locker_number = nil

    [name, email, membership_type, paid_until, stripe_id, rfid, notes, locker_number]
  end
end
