module Ynabify
  module Conversion
    class Converter
      def self.convert(infile, outfile, interactive)
        new(infile, outfile, interactive).convert
      end

      def initialize(infile, outfile, interactive)
        @infile      = infile
        @outfile     = outfile
        @interactive = interactive
      end
    end
  end
end
