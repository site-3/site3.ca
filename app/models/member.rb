#
# A Member is someone who has a subscription at Site 3 or is interested in one
#

class Member < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :email, presence: true
end
