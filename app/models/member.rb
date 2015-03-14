#
# A Member is someone who has a subscription at Site 3 or is interested in one
#

class Member < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
end
