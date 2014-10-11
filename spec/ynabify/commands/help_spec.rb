require 'spec_helper'

# Stub command to make this test easier
module Ynabify
  module Commands
    class TestCommand < Command
      def self.help
        "This is a test of the emergency broadcast system"
      end
    end
  end
end


describe Ynabify::Commands::Help do
  context "#execute" do
    let( :argv    ) { ["test_command", "ignored"] }
    let( :command ) { described_class.new(argv)   }

    before(:each) do
      allow(Ynabify::Dispatcher).to receive(:valid_command?).
        with("test_command").and_return(true)
    end

    it "should look up the command named by the first param" do
      expect(Ynabify::Commands::Command).to receive("lookup").
        with("test_command").and_return(Ynabify::Commands::TestCommand)

      command.execute
    end

    it "should call the help method on the passed-on command" do
      expect(Ynabify::Commands::TestCommand).to receive(:help)
      
      command.execute
    end

    it "should output the help text on stdout" do
      expect{ command.execute}.
        to match_stdout("This is a test of the emergency broadcast system")
    end
  end
end
