class OauthIdentity < ApplicationRecord
  belongs_to :member

  validates :member, presence: true

  def self.find_with_omniauth(auth)
    where(
      uid: auth['uid'],
      provider: auth['provider'],
    ).first
  end

  def self.create_with_omniauth(member, auth)
    create!(
      member: member,
      uid: auth['uid'],
      provider: auth['provider'],
    )
  end
end
