require 'spec_helper'

describe Ynabify::Commands::Convert do
  let( :argv    ) { [] }
  let( :command ) { described_class.new(argv) }

  context "self" do
    context ".help" do
      it "should return usage information for the help command" do
        expect(described_class.help).to eq(<<-TEXT)
ynabify convert
Runs the conversion process. With no flags, consumes from STDIN
and outputs STDOUT

ynabify convert <infile> <outfile>
Shortcut for ynabify convert -i <infile> -o <outfile>

Accepted flags:
-i --infile: the file to read in. If absent, uses STDIN

-o --outfile: the file to output. If absent, uses STDOUT

-I --interactive: runs the converter in interactive mode, prompting
the user to create a rewrite rule for any row that does not
already have one

-m --mapping: specifies the yaml file to use to specify the mapping
of columns from input to output. If absent, will use the default
        TEXT
      end
    end
  end

  context "#execute" do
    context "valid" do
      before(:each) do
        expect(command).to receive(:validate).and_return(true)

        @infile      = :stdio
        @outfile     = :stdout
        @interactive = false

        expect(command).to receive( :infile       ).and_return( @infile      )
        expect(command).to receive( :outfile      ).and_return( @outfile     )
        expect(command).to receive( :interactive? ).and_return( @interactive )
      end

      it "should instantiate a converter" do
        expect(Ynabify::Conversion::Converter).to receive(:convert).
          with(@infile, @outfile, @interactive)

        command.execute
      end
    end

    context "invalid" do
      before(:each) do
        expect(command).to receive(:validate).and_return(false)
      end

      it "should not instantiate a converter" do
        expect(Ynabify::Conversion::Converter).not_to receive(:convert)

        command.execute
      end
    end
  end

  context "#validate" do
    context "valid" do
      it "should return true" do
        expect(command.validate).to be true
      end
    end

    context "wrong number of params" do
      let(:argv) { ["one_file.csv"] }

      it "should return false" do
        expect(command.validate).to be false
      end

      it "should call print_arg_num_error" do
        expect(command).to receive(:print_arg_num_error)
        command.validate
      end
    end

    context "flag missing value" do
      context "missing mapping" do
        let(:argv) { ["-m"] }

        it "should return false" do
          expect(command.validate).to be false
        end

        it "should print flag value error for mapping" do
          expect(command).to receive(:print_flag_needs_value).with(:mapping)
          command.validate
        end
      end
      context "missing infile" do
        let(:argv) { ["-i", "-o", "outfile.csv"] }

        it "should return false" do
          expect(command.validate).to be false
        end

        it "should print flag value error for infile" do
          expect(command).to receive(:print_flag_needs_value).with(:infile)
          command.validate
        end
      end

      context "missing outfile" do
        let(:argv) { ["-i", "infile.csv", "-o"] }

        it "should return false" do
          expect(command.validate).to be false
        end

        it "should print flag value error for outfile" do
          expect(command).to receive(:print_flag_needs_value).with(:outfile)
          command.validate
        end
      end
    end
  end

  context "#infile" do
    # I don't like this spec but didn't want to have to copy
    # the setup code like twelve times
    it "should return the infile name, following priority rules" do
      param_command = described_class.new( 
                       ["p_infile", "p_outfile", "-i", "s_infile", "--infile", "l_infile"] )

      expect(param_command.infile).to eq("p_infile")

      short_command = described_class.new(
        ["-i", "s_infile", "--infile", "l_infile"])

      expect(short_command.infile).to eq("s_infile")

      long_command = described_class.new(
        ["--infile", "l_infile"])

      expect(long_command.infile).to eq('l_infile')
    end

    it "should return :stdin if no infile given" do
      expect(command.infile).to eq(:stdin)
    end
  end

  context "#outfile" do
    # I don't like this spec but didn't want to have to copy
    # the setup code like twelve times
    it "should return the outfile name, following priority rules" do
      param_command = described_class.new( 
                       ["p_infile", "p_outfile", "-o", "s_outfile", "--outfile", "l_outfile"] )

      expect(param_command.outfile).to eq("p_outfile")

      short_command = described_class.new(
        ["-o", "s_outfile", "--outfile", "l_outfile"])

      expect(short_command.outfile).to eq("s_outfile")

      long_command = described_class.new(
        ["--outfile", "l_outfile"])

      expect(long_command.outfile).to eq('l_outfile')
    end

    it "should return :stdout if no outfile given" do
      expect(command.outfile).to eq(:stdout)
    end
  end

  context "#interactive?" do
    it "should return true if -I or --interactive flags present" do
      expect( described_class.new(["-I"]).interactive? ).to be true
      expect( described_class.new(["--interactive"]).interactive? ).to be true
    end

    it "should return false if both flags are absent" do
      expect(command.interactive?).not_to be true
    end
  end
end
