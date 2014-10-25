module Ynabify
  module Conversion
    class Converter
      def self.convert(infile, outfile, interactive, mapping)
        new(infile, outfile, interactive, mapping).convert
      end

      def initialize(infile, outfile, interactive, mapping)
        @infile       = infile
        @outfile      = outfile
        @interactive  = interactive
        @mapping_file = mapping 
      end
    end
  end
end
