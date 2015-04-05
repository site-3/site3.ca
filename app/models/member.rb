#
# A Member is someone who has a subscription at Site 3 or is interested in one
#

class Member < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :oauth_identities

  validates :name, presence: true

  def rfid=(rfid)
    self[:rfid] = rfid.downcase
  end

  def self.from_omniauth_identity(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end
end
