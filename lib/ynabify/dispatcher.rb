# Class responsible for parsing command line arguments
# and dispatching to the relevant classes

module Ynabify
  class Dispatcher
    attr_reader :subcommand, :opts

    VALID_COMMANDS = %w( help edit convert )

    COMMANDS = {
      "help"    => Ynabify::Commands::Help,
      "edit"    => Ynabify::Commands::Edit,
      "convert" => Ynabify::Commands::Convert
    }

    def self.dispatch(argv)
      new(argv).dispatch
    end

    def self.valid_commands
      COMMANDS.keys
    end

    def initialize(argv)
      @subcommand = argv.shift
      @opts       = argv
    end

    def dispatch
      if valid_command?
        COMMANDS[@subcommand].execute(@opts)
      else
        Ynabify::Commands::Error.execute( [@subcommand] )
      end
    end

    def valid_command?
      self.class.valid_commands.include? @subcommand
    end
  end
end
