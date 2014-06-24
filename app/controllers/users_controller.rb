class UsersController < Devise::OmniauthCallbacksController
  before_filter :require_login, only: :show
  before_filter :require_no_authentication, except: [:show]
  before_filter :require_valid_omniauth_hash, only: (Devise.omniauth_providers << :omniauth_callback)
  respond_to :html

  def show
    @user = User.find_by(username: params[:id], provider: params[:provider])
    if @user == current_user
      respond_with(@user)
    else
      redirect_to user_url(current_user)
    end
  end

  def after_omniauth_failure_path_for(scope)s
    login_path(current_institution.code.downcase)
  end

  def omniauth_callback
    @user = User.find_or_initialize_by(username: omniauth_hash_map.username, provider: omniauth_hash_map.provider)
    # Initialize with an email address if the omniauth hash has it.
    @user.email = omniauth_hash_map.email if @user.email.blank? && omniauth_hash_map.email.present?
    # Set the OmniAuth::AuthHash for the user
    @user.omniauth_hash_map = omniauth_hash_map.to_hash
    if @user.save
      @identity = @user.identities.find_or_initialize_by(uid: omniauth_hash_map.uid, provider: omniauth_hash_map.provider)
      @identity.properties = omniauth_hash_map.properties if @identity.expired?
      @identity.save
      sign_in_and_redirect @user, event: :authentication
      kind = omniauth_hash_map.provider.titleize
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      redirect_to after_omniauth_failure_path_for(resource_name)
    end
  end

  Devise.omniauth_providers.each do |omniauth_provider|
    alias_method omniauth_provider, :omniauth_callback
  end

  def require_login
    unless user_signed_in?
      redirect_to login_url
    end
  end
  private :require_login

  def require_valid_omniauth_hash
    require_login unless omniauth_hash_map
  end
  private :require_valid_omniauth_hash

  def omniauth_hash_map
    @omniauth_hash_map ||= ::Login::OmniAuthHashManager::Mapper.new(request.env["omniauth.auth"])
  end
  private :omniauth_hash_map
end
