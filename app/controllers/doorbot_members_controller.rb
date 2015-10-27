class DoorbotMembersController < ApplicationController
  def index
    token = params[:token]
    raise "Incorrect token"  unless Devise.secure_compare(Rails.application.secrets.doorbot_members_token, token)

    @doorbot_members = Member.doorbot_enabled
  end
end
