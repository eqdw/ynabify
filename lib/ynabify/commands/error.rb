module Ynabify
  module Commands
    class Error < Command
      def execute
        puts <<-TEXT
        Invalid command: #{@params.first}
        Valid commands are #{Ynabify::Dispatcher.valid_commands.join(", ")}
        Use `ynabify help <subcommand>` for details on a subcommand
        TEXT
      end
    end
  end
end
