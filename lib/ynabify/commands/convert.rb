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
    end
  end
end
