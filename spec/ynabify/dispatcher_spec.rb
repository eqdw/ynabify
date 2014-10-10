require 'spec_helper'

describe Ynabify::Dispatcher do
  let( :argv       ) { %w(cat says meow)             }
  let( :dispatcher ) { Ynabify::Dispatcher.new(argv) }

  context "self" do
    context ".valid_commands" do
      it "should return a list of all valid commands" do
        expect(Ynabify::Dispatcher.valid_commands).to eq(Ynabify::Dispatcher::COMMANDS.keys)
      end
    end
  end

  context "#initialize" do
    it "should parse out the sub-command" do
      expect(dispatcher.subcommand).to eq "cat"
    end

    it "should parse out the options" do
      expect(dispatcher.opts).to eq %w(says meow)
    end
  end

  context "#valid_command?" do
    Ynabify::Dispatcher::COMMANDS.keys.each do |command|
      let( :dispatcher ) { Ynabify::Dispatcher.new([command]) }

      it "should return true for #{command}" do
        expect( dispatcher.valid_command? ).to be true
      end
    end

    it "should return false for any command not in the list" do
      dispatcher = Ynabify::Dispatcher.new(["derp"])
      expect( dispatcher.valid_command? ).to be false
    end
  end

  context "#dispatch" do
    context "valid command" do
      let( :argv ) { %w(help is a real command) }

      before(:each) do
        allow(dispatcher).to receive(:valid_command?).and_return(true)
      end

      it "should invoke the subcommand with the provided opts" do
        expect(Ynabify::Commands::Help).to receive(:execute).with(%w( is a real command) )

        dispatcher.dispatch
      end
    end

    context "invalid command" do
      before(:each) do
        allow(dispatcher).to receive(:valid_command?).and_return(false)
      end

      it "should print out the error message" do
        expect(Ynabify::Commands::Error).to receive(:execute)

        dispatcher.dispatch
      end

      it "should pass in the subcommand (and not the opts)" do
        expect(Ynabify::Commands::Error).to receive(:execute).with(%w(cat))

        dispatcher.dispatch
      end
    end
  end
end
