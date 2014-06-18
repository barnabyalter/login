module LoginFeatures
  module Shibboleth
    def nyu_home_url(institute = "NYU")
      user_omniauth_authorize_path({provider: "nyu_shibboleth"}.merge(institute_user(institute)))
    end

    def login_as_nyu_shibboleth
      OmniAuth.config.mock_auth[:nyu_shibboleth] = OmniAuth::AuthHash.new(shibboleth_hash)
    end

    private

    def shibboleth_hash
      @shibboleth_hash ||= {
        provider: "nyu_shibboleth",
        uid: "js123",
        info: {
          first_name: "Jon",
          last_name: "Snow",
          email: "snowj@newschool.edu",
          nickname: "12345",
          location: ", , ,  ",
          uid: "js123"
        }
      }
    end

    def shibboleth_username_for_institute(institute)
      case institute
      when /NYU New York/
        :dev123
      when /NYU Abu Dhabi/
        :addev123
      when /NYU Shanghai/
        :shdev123
      else
        raise "Unknown Shibboleth institute!"
      end
    end

    def institute_user(institute)
      meth = "dummy_#{institute.downcase}_user"
      send(meth.to_sym) if defined?(meth.to_sym) == "method"
    end

    def dummy_nyu_user
      dummy_user.merge({
        institute: "NYU",
        uid: shibboleth_username_for_institute("NYU New York")
      })
    end

    def dummy_nyush_user
      dummy_user.merge({
        institute: "NYUSH",
        uid: shibboleth_username_for_institute("NYU Shanghai")
      })
    end

    def dummy_nyuad_user
      dummy_user.merge({
        institute: "NYUAD",
        uid: shibboleth_username_for_institute("NYU Abu Dhabi")
      })
    end

    def dummy_user
      {
        "Shib-Session-ID" => "123",
        "Shib-Application-ID" => "123",
        email: "dev123@example.com",
        givenName: "Dev",
        firstName: "Dev",
        sn: "Eloper",
        nyuidn: "N12345678"
      }
    end
  end
end
