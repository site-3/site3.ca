class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # Log in the member with the email that was in the OAuth response from Facebook
  # Facebook emails in the oauth response are always verified
  def facebook
    @oauth_identity = OauthIdentity.find_with_omniauth(auth_hash)

    if @oauth_identity.present?
      member = @oauth_identity.member
    else
      # create an OauthIdentity for the user with this email
      email = auth_hash['info']['email']
      member = Member.find_by_email(email)

      if auth_hash['info']['verified'] != true
        return  redirect_to after_omniauth_failure_path_for(resource_name), alert: "Facebook account must be verified."
      end

      if member.nil?
        return  redirect_to after_omniauth_failure_path_for(resource_name), alert: "No member found for that Facebook account."
      end

      @ouath_identity = OauthIdentity.create_with_omniauth(member, auth_hash)
    end

    sign_in(:member, member)
    redirect_to after_sign_in_path_for(nil)
  end

private
  def auth_hash
    request.env['omniauth.auth']
  end
end
