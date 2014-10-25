require 'spec_helper'

describe Ynabify::Conversion::Converter do
  let( :infile      ) { :stdin   }
  let( :outfile     ) { :stdout  } 
  let( :interactive ) { false    }
  let( :mapping     ) { :default }

  context "self" do
    context ".convert" do
      it "should initialize a new converter" do
        expect(described_class).to receive(:new).
          with(infile, outfile, interactive, mapping).and_return( spy("converter") )

        described_class.convert(infile, outfile, interactive, mapping)
      end

      it "should call convert on the intialized converter" do
        converter = double("converter")

        expect(converter).to receive(:convert)

        allow(described_class).to receive(:new).and_return(converter)


        described_class.convert(infile, outfile, interactive, mapping)
      end
    end
  end
end
