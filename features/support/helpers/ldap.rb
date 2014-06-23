module LoginFeatures
  module Ldap

    def login_as_newschool_ldap
      OmniAuth.config.mock_auth[:new_school_ldap] = OmniAuth::AuthHash.new(newschool_hash)
    end

    def submit_invalid_credentials_to_newschool_ldap
      OmniAuth.config.mock_auth[:new_school_ldap] = :invalid_credentials
    end

    def newschool_callback_url
      user_omniauth_authorize_path(:provider => "new_school_ldap")
    end

    private

    def newschool_hash
      {
        provider: "new_school_ldap",
        uid: "uid=12345,ou=people,o=newschool.edu,o=cp",
        info: {
          first_name: "Jon",
          last_name: "Snow",
          email: "snowj@1newschool.edu",
          nickname: "12345",
          location: "",
          uid: "uid=12345,ou=people,o=newschool.edu,o=cp"
        },
        extra:
        {
          raw_info:
            Net::LDAP::Entry.new({
              dn: ["uid=12345,ou=people,o=newschool.edu,o=cp"],
              displayname: ["Jon Snow"],
              givenname: ["Jon"],
              objectclass: ["top"],
              pdsacademicmajor: ["cn=Non-degree,ou=Major,o=newschool.edu,o=cp"],
              pdsexternalsystemid:
                ["12345::gtmb",
                "snowj@1newschool.edu::mir3",
                "N00000000::sct"],
              mail: ["snowj@1newschool.edu"],
              sn: ["Snow"],
              pdsemaildefaultaddress: ["snowj@1newschool.edu"],
              uid: ["12345"],
              pdsloginid: ["snowj"],
              pdsloginalias: ["snowj"],
              pdsrole: ["ns_staff"]
            })
          }
        }
    end

  end
end
