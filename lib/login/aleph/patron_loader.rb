module Login
  module Aleph
    class PatronLoader
      attr_reader :identifier

      def initialize(identifier)
        @identifier = identifier
      end

      def patron
        flat_file_strategy.patron || bor_info_strategy.patron
      end

    private

      def bor_info_strategy
        @bor_info_strategy ||= BorInfoStrategy.new(identifier)
      end

      def flat_file_strategy
        @flat_file_strategy ||= FlatFileStrategy.new(identifier)
      end
    end
  end
end
