require 'yaml'

module Ynabify
  module Conversion
    class Mapping
      def self.init_from_file(filename)
        yaml = YAML.load_file(filename)

        new(yaml["input_columns"], yaml["output_columns"], yaml["maphash"])

      end

      def initialize(input_columns, output_columns, maphash=nil)
        @input_columns  = input_columns
        @output_columns = output_columns
        @maphash        = maphash || default_maphash(@input_columns, @output_columns)
      end


      def output_order
        @output_columns
      end

      def [](out)
        @maphash[out]
      end


      private

      # goes pairwise down input and output,
      # and computes each key of the output to
      # be the corresponding key of input in the
      # paired array
      # If there are more elements in input than
      # output, they are ignored
      # If there are more elements of output than
      # input, they are set to nil
      def default_maphash(input, output)
        maphash = {}

        output.each_with_index do |outcol, i|
          incol = input[i]
          maphash[outcol] = incol
        end

        maphash
      end
    end
  end
end
