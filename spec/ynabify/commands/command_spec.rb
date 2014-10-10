require 'spec_helper'

describe Ynabify::Commands::Command do
  let( :argv    ) { [ "command", "-a", "flag", "-A", "nother_flag"] }

  context "self" do
    context ".execute" do
      after(:each) do 
        Ynabify::Commands::Command.execute(argv)
      end

      it "should initialize a new command" do
        expect(Ynabify::Commands::Command).to receive(:new).and_return(spy())
      end

      it "should call execute on it" do
        expect_any_instance_of(Ynabify::Commands::Command).to receive(:execute).and_return(nil)
      end
    end
  end

  context "#initialize" do 
    it "should parse the arguments" do
      expect_any_instance_of(Ynabify::Commands::Command).to receive(:parse_flags).with(argv)
      Ynabify::Commands::Command.new(argv)
    end
  end

  context "#parse_flags" do
    let( :command      ) { Ynabify::Commands::Command.new(argv) }
    let( :parsed_flags ) { command.parse_flags(argv)  }

    it "should return a hash of flag-value pairs" do
      expect( parsed_flags ).to eq("a" => "flag", "A" => "nother_flag")
    end

    it "should ignore non-flag args" do
      expect( parsed_flags.keys   ).not_to include "command"
      expect( parsed_flags.values ).not_to include "command"
    end
  end

  context "#execute" do
    let( :command ) { Ynabify::Commands::Command.new(argv) }

    it "should be overridden in child classes" do
      expect { command.execute }.to raise_error
    end
  end
end
