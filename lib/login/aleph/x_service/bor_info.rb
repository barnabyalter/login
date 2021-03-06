module Login
  module Aleph
    module XService
      class BorInfo < Base
        DEFAULT_SHOW_LOANS_VALUE = "N"
        DEFAULT_SHOW_CASH_VALUE = "N"
        DEFAULT_SHOW_HOLD_VALUE = "N"
        DEFAULT_SHOW_FILTER_CASH_VALUE = "N"

        attr_accessor :identifier, :op

        def initialize(identifier)
          @identifier = identifier
          @op = self.class.name.demodulize.underscore # I.e. bor_info
          super()
        end

      protected

        # We're only interested in the user information, not loans or cash, etc.
        # https://developers.exlibrisgroup.com/aleph/apis/Aleph-X-Services/bor_info
        def options
          @options ||= super.merge({
            loans: DEFAULT_SHOW_LOANS_VALUE,
            cash: DEFAULT_SHOW_CASH_VALUE,
            hold: DEFAULT_SHOW_HOLD_VALUE,
            filter_cash: DEFAULT_SHOW_FILTER_CASH_VALUE
          })
        end

      end
    end
  end
end
