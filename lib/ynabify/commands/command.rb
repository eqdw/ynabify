# Generic subclass for running a subcommand
# Subcommands should subclass this

module Ynabify
  module Commands
    class Command
      def self.execute(argv)
        new(argv).execute
      end

      def initialize(argv)
        @params = parse_params( argv )
        @flags  =  parse_flags( argv )
      end

      def parse_flags(argv)
        args = argv.dup
        parsed = {}

        while(arg = args.shift)
          # if it's a flag
          if( match = (arg.match /^-(.*)/) )
            parsed[ match[1] ] = args.shift
          end
        end

        parsed
      end

      def parse_params(argv)
        args = argv.dup
        params = []

        while( arg = args.shift)
          # if it's a flag
          if( match = (arg.match /^-/))
            # burn off the flag and it's value
            args.shift
          else
            params << arg
          end
        end

        params
      end

      def execute
        raise "you should only execute a subclass of Command"
      end
    end
  end
end
