class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_for_paper_trail
    current_member
  end

  def after_sign_in_path_for(member)
    edit_member_registration_path
  end
end
