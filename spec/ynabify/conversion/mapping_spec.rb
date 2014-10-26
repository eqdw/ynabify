require 'spec_helper'

describe Ynabify::Conversion::Mapping do
  let( :input_columns  ) { ["Transaction Date", "Description", "Amount", "Category"]}
  let( :output_columns ) { ["Date", "Payee", "Category", "Memo", "Outflow", "Inflow" ]}
  let( :maphash        ) { {"Date" => "Transaction Date", "Payee" => "Description" }}

   let( :mapping       ) { described_class.new(input_columns, output_columns, maphash) }

  context "#initialize" do
    context "no maphash" do
      it "should call default_maphash with the input and output columns" do
        expect_any_instance_of(described_class).to receive(:default_maphash).
          with(input_columns, output_columns)

        described_class.new(input_columns, output_columns)
      end
    end

    context "maphash" do
      it "should not call default_maphash" do
        expect_any_instance_of(described_class).not_to receive(:default_maphash)

        described_class.new(input_columns, output_columns, maphash)
      end
    end
  end

  context "#output_order" do
    it "should return @output_columns" do
      expect(mapping.output_order).to eq(output_columns)
    end
  end

  context '#[]' do
    it "should delegate to the underlying @maphash" do
      expect(maphash).to receive(:[]).with("Date")

      mapping["Date"]
    end
  end
end
