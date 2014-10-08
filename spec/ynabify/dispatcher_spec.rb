require 'spec_helper'

describe Ynabify::Dispatcher do
  let( :argv       ) { %w(cat says meow)             }
  let( :dispatcher ) { Ynabify::Dispatcher.new(argv) }

  context "#initialize" do
    it "should parse out the sub-command" do
      expect(dispatcher.subcommand).to eq "cat"
    end

    it "should parse out the options" do
      expect(dispatcher.opts).to eq %w(says meow)
    end
  end

  context "#valid_command?" do
    Ynabify::Dispatcher::VALID_COMMANDS.each do |command|
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
      before(:each) do
        allow(dispatcher).to receive(:valid_command?).and_return(true)
      end

      it "should invoke the subcommand with the provided opts" do
        expect(dispatcher).to receive(:cat).with( %w( says meow) )

        dispatcher.dispatch
      end
    end

    context "invalid command" do
      before(:each) do
        allow(dispatcher).to receive(:valid_command?).and_return(false)
      end

      it "should print out the error message" do
        expect(dispatcher).to receive(:error_message)

        dispatcher.dispatch
      end
    end
  end
end
