# The help class invokes the help methods on each other command
# it uses the first arg passed in as the command to look up
# and ignores all flags

module Ynabify
  module Commands
    class Help < Command
      def self.help
        <<-TEXT
ynabify help <command>
Outputs usage information for the given command
        TEXT
      end

      def execute
        help_command = lookup(@params.first)

        puts help_command.help
      end
    end
  end
end
