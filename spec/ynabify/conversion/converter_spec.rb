require 'spec_helper'
require 'csv'

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

  context "#make_mapping" do
    let( :converter ) { Ynabify::Conversion::Converter.new(infile, outfile, interactive, mapping) }

    context "by default" do
      let( :parsed_input_headers  ) { %w( This Is Some Input  ) }
      let( :parsed_output_headers ) { %w( This Is Some Output ) }

      before(:each) do
        expect(converter).to receive(:parse_headers!).with( infile  ).and_return( parsed_input_headers  )
        expect(converter).to receive(:parse_headers!).with( outfile ).and_return( parsed_output_headers )
      end

      it "should parse_headers from the infile and outfile" do
        # The method stubs in the before() are this test
        converter.make_mapping(mapping)
      end

      it "should create a new mapping from the parsed headers" do
        # note we stubbed the return value of parse_headers to be these
        expect(Ynabify::Conversion::Mapping).to receive(:new).with( parsed_input_headers, parsed_output_headers)
        converter.make_mapping(mapping)
      end
    end

    context "with a filename" do
      let( :mapping ) { "sample.yml" }

      it "should call Mapping.init_from_file with the filename" do
        expect(Ynabify::Conversion::Mapping).to receive(:init_from_file).with(mapping)

        converter.make_mapping(mapping)
      end
    end
  end

  context "#parse_headers!" do
    let( :csv_header_text ) { <<-CSV }
This, Is, A, Header, Row
this, is, a, data, row
this, is, more, data, row
    CSV

    let( :converter ) { Ynabify::Conversion::Converter.new(infile, outfile, interactive, mapping) }

    before(:each) do
      parsed_csv = double('csv', :gets => nil, :headers => %w(This Is A Header Row))
      expect(CSV).to receive(:open).and_return(parsed_csv)
    end

    it "should return a list of parsed headers " do
      expect(converter.parse_headers!(infile)).
        to eq( %w(This Is A Header Row) )
    end
  end
end
