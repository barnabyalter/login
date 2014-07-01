##
#
module Login
  module OmniAuthHash
    module Providers
      class Facebook < Login::OmniAuthHash::Providers::Base

        def username
          @omniauth_hash.info.nickname || @omniauth_hash.info.email
        end

      end
    end
  end
end
