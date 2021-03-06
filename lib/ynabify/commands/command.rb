# Generic subclass for running a subcommand
# Subcommands should subclass this

module Ynabify
  module Commands
    class Command
      def self.lookup(command_name)
        if Ynabify::Dispatcher.valid_command?(command_name.downcase)
          "Ynabify::Commands::#{command_name.camelize}".constantize
        end
      end

      def self.help
        raise "you must implement help on command subclasses"
      end

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
          if( match = is_flag?(arg) )

            # if it's a boolean flag, the next arg is also a flag
            # alternatively, if there are no args left but this one
            # is a flag, it's a boolean flag
            val = if args.length == 0
                    true
                  elsif is_flag?(args.first)
                    true
                  else
                    args.shift
                  end

            parsed[ match[1] ] = val
          end
        end

        parsed
      end

      def parse_params(argv)
        args = argv.dup
        params = []

        while( arg = args.shift)
          # if it's a flag
          if( match = is_flag?(arg))
            # burn off the flag and it's value
            args.shift
          else
            params << arg
          end
        end

        params
      end

      def lookup(command_name)
        Ynabify::Commands::Command.lookup(command_name)
      end

      def execute
        raise "you should only execute a subclass of Command"
      end

      private

      def is_flag?(arg)
        arg.match(/^-(.*)/)
      end
    end
  end
end
