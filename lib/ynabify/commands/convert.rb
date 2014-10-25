module Ynabify
  module Commands
    class Convert < Command
      def self.help
        <<-TEXT
ynabify convert
Runs the conversion process. With no flags, consumes from STDIN
and outputs STDOUT

ynabify convert <infile> <outfile>
Shortcut for ynabify convert -i <infile> -o <outfile>

Accepted flags:
-i --infile: the file to read in. If absent, uses STDIN

-o --outfile: the file to output. If absent, uses STDOUT

-I --interactive: runs the converter in interactive mode, prompting
the user to create a rewrite rule for any row that does not
already have one

-m --mapping: specifies the yaml file to use to specify the mapping
of columns from input to output. If absent, will use the default
        TEXT
      end


      def execute
        if validate
          Ynabify::Conversion::Converter.convert(infile, outfile, interactive?)
        end
      end


      def validate
        valid = true

        if @params.length != 0 && @params.length != 2
          valid = false
          print_arg_num_error
        end

        if @flags['i'] == true || @flags["-infile"] == true
          valid = false
          print_flag_needs_value(:infile)
        end
        
        if @flags['o'] == true || @flags["-outfile"] == true
          valid = false
          print_flag_needs_value(:outfile)
        end

        if @flags['m'] == true || @flags["-mapping"] == true
          valid = false
          print_flag_needs_value(:mapping)
        end

        valid
      end

      def print_arg_num_error
        puts <<-TEXT
Invalid invocation. Must provide either zero or two filenames,
or use flags.
        TEXT
      end

      def print_flag_needs_value(flag)
        puts <<-TEXT
Invalid invocation. Must provide filename for #{flag.to_s} flag
        TEXT
      end

      def infile
        if @params.length == 2
          @params[0]
        elsif @flags['i']
          @flags['i']
        elsif @flags['-infile']
          @flags['-infile']
        else
          :stdin
        end
      end

      def outfile
        if @params.length == 2
          @params[1]
        elsif @flags['o']
          @flags['o']
        elsif @flags['-outfile']
          @flags['-outfile']
        else
          :stdout
        end
      end

      def interactive?
        @flags["I"] || @flags["-interactive"]
      end

      def mapping_file
        @flags["m"] || @flags["-mapping"] || :default
      end
    end
  end
end
