module LoginFeatures
  module Doorkeeper

    def current_resource_owner(provider = "nyu_shibboleth")
      @current_resource_owner ||= User.where(username: Login::OmniAuthHashManager::Mapper.new(eval("#{provider}_omniauth_hash")).username, provider: provider).first
    end

    def auth_code
      @auth_code ||= page.find("#authorization_code").text
    end

    def client_authorize_url
      @client_authorize_url ||= client.auth_code.authorize_url(:redirect_uri => oauth_app.redirect_uri)
    end

    def access_token
      @access_token ||= client.auth_code.get_token(auth_code, :redirect_uri => oauth_app.redirect_uri).token
    end

    def client
      @client ||= OAuth2::Client.new(oauth_app.uid, oauth_app.secret, site: provider_url)
    end

    def oauth_app
      @oauth_app ||= FactoryGirl.create(:oauth_app_no_redirect)
    end

    def provider_url
      visit login_path
      racktest_url = URI.parse(current_url)
      return @provider_url ||= "#{racktest_url.scheme}://#{racktest_url.host}:#{racktest_url.port}"
    end

  end
end
