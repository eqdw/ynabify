module Ynabify
  module Conversion
    class Converter
      def self.convert(infile, outfile, interactive, mapping)
        new(infile, outfile, interactive, mapping).convert
      end

      def initialize(infile, outfile, interactive, mapping)
        @infile      = infile
        @outfile     = outfile
        @interactive = interactive
        @mapping     = mapping
      end


      def convert
        init_objects #open files here, not in new
      end


      def make_mapping(mapping)
        if mapping == :default
          input_columns  = parse_headers!( @infile  )
          output_columns = parse_headers!( @outfile )
          Mapping.new(input_columns, output_columns)
        else
          Mapping.init_from_file(mapping)
        end
      end

      # Parses out the first row
      def parse_headers!(csv_file)
        csv = CSV.open(csv_file, :headers => true)
        csv.gets
        csv.headers
      end
    end
  end
end
