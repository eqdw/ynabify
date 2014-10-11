# Class responsible for parsing command line arguments
# and dispatching to the relevant classes

module Ynabify
  class Dispatcher
    attr_reader :subcommand, :opts

    COMMANDS = %w(help edit convert).inject({}) do |hash, command|
      hash[command] = "Ynabify::Commands::#{command.camelize}".constantize
      hash
    end

    def self.dispatch(argv)
      new(argv).dispatch
    end

    def self.valid_commands
      COMMANDS.keys
    end

    def self.valid_command?(command)
      valid_commands.include?(command)
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
      self.class.valid_command? @subcommand
    end
  end
end
