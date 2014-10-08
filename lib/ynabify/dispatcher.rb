# Class responsible for parsing command line arguments
# and dispatching to the relevant classes

module Ynabify
  class Dispatcher
    attr_reader :subcommand, :opts

    VALID_COMMANDS = %w( help edit-rules convert )

    def self.dispatch(argv)
      new(argv).dispatch
    end

    def initialize(argv)
      @subcommand = argv.shift
      @opts       = argv
    end

    def dispatch
      if valid_command?
        self.send(@subcommand, @opts)
      else
        puts error_message
      end
    end

    def valid_command?
      VALID_COMMANDS.include? @subcommand
    end

    def error_message
      <<-EOT
      valid subcommands are #{COMMANDS.join(", ")}
      `ynabify help <subcommand>` for details on a subcommand
      EOT
    end
  end
end
