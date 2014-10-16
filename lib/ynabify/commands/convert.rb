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
        TEXT
      end


      def execute
        if validate

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

        valid
      end

      def print_arg_num_error
        puts <<-TEXT
Invalid invocation. Must provide either zero or two filenames,
or use flags.
        TEXT
      end

      def print_flag_needs_value(in_or_out)
        puts <<-TEXT
Invalid invocation. Must provide filename for #{in_or_out.to_s} flag
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
    end
  end
end
