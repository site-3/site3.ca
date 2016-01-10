#
# A MemberApplication holds information we ask for from perspective members
# not all Members will fill in a MemberApplication.
#

class MemberApplication < ActiveRecord::Base
  has_paper_trail

  belongs_to :member

  validates :name, presence: true
  validates :email, presence: true # TODO validate format
end
