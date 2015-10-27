class DoorbotMembersController < ApplicationController
  def index
    @doorbot_members = Member.doorbot_enabled
  end
end
