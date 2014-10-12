require 'spec_helper'

describe Ynabify::Commands::Command do
  let( :argv    ) { [ "command", "-a", "flag", "-A", "nother_flag", "-b", "-oolean_flag"] }

  context "self" do
    context ".lookup" do
      it "should return a command class" do
        expect( described_class.lookup("Help")).
          to eq(Ynabify::Commands::Help)
      end

      it "should be generous towards uncamelized names" do
        expect( described_class.lookup("help")).
          to eq(Ynabify::Commands::Help)
      end

      it "should return nil on invalid command name" do
        expect( described_class.lookup("herpderp")).to be_nil
      end
    end

    context ".help" do
      it "should raise an error" do
        expect { described_class.help }.to raise_error
      end
    end

    context ".execute" do
      after(:each) do 
        described_class.execute(argv)
      end

      it "should initialize a new command" do
        expect(described_class).to receive(:new).and_return(spy())
      end

      it "should call execute on it" do
        expect_any_instance_of(described_class).to receive(:execute).and_return(nil)
      end
    end
  end

  context "#initialize" do 
    it "should parse the arguments" do
      expect_any_instance_of(described_class).to receive( :parse_flags  ).with(argv)
      expect_any_instance_of(described_class).to receive( :parse_params ).with(argv)
      described_class.new(argv)
    end
  end

  context "#parse_flags" do
    let( :command      ) { described_class.new(argv) }
    let( :parsed_flags ) { command.parse_flags(argv) }

    it "should return a hash of flag-value pairs" do
      expect( parsed_flags ).to include("a" => "flag", "A" => "nother_flag")
    end

    it "should ignore non-flag args" do
      expect( parsed_flags.keys   ).not_to include "command"
      expect( parsed_flags.values ).not_to include "command"
    end

    it "should work for boolean flags" do
      expect( parsed_flags ).to include("b" => true, "oolean_flag" => true)
    end
  end

  context "#parse_params" do
    let( :command       ) { described_class.new(argv) }
    let( :parsed_params ) { command.parse_params(argv)           }

    it "should return an array of all non-flag values in the params" do
      expect( parsed_params ).to eq( ["command"] )
    end

    it "should ignore all flag args" do
      %w(-a flag -A nother_flag).each do |flag_arg|
        expect( parsed_params ).not_to include(flag_arg)
      end
    end
  end

  context "#lookup" do
    let( :command ) { described_class.new(argv) }

    it "should call the class method" do
      expect(Ynabify::Commands::Command).to receive(:lookup).with("help")

      command.lookup("help")
    end
  end

  context "#execute" do
    let( :command ) { described_class.new(argv) }

    it "should be overridden in child classes" do
      expect { command.execute }.to raise_error
    end
  end
end
