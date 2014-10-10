require 'spec_helper'

describe Ynabify::Commands::Error do

  context "#execute" do
    let( :argv  ) { ["qrrbrbirlbel"]                   }
    let( :error ) { Ynabify::Commands::Error.new(argv) }


    it "should let the user know the command was invalid" do
      expect{ error.execute }.to match_stdout "Invalid command: #{argv.first}"
    end

    it "should print out the list of commands" do
      expect{ error.execute}.to match_stdout "Valid commands are #{Ynabify::Dispatcher.valid_commands.join(", ")}"
    end

    it "should show help syntax" do
      expect{ error.execute}.to match_stdout "Use `ynabify help <subcommand>` for details on a subcommand"
    end
  end
end
