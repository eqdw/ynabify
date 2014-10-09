# Generic subclass for running a subcommand
# Subcommands should subclass this

module Ynabify
  class Command
    def self.execute(argv)
      new(argv).execute
    end

    def initialize(argv)
      @flags = parse_flags(argv)
    end

    def parse_flags(argv)
      args = argv.dup
      parsed = {}

      while(arg = args.shift)
        # if it's a flag
        if match = (arg.match /^-(.*)/)
          parsed[ match[1] ] = args.shift
        end
      end

      parsed
    end

    def execute
      raise "you should only execute a subclass of Command"
    end
  end
end

