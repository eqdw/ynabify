require 'spec_helper'

describe Ynabify::Dispatcher do

  context "#initialize" do
    let( :argv       ) { %w(Cat Says Meow)             }
    let( :dispatcher ) { Ynabify::Dispatcher.new(argv) }


    it "should parse out the sub-command" do
     expect(dispatcher.subcommand).to eq "Cat"
    end

    it "should parse out the options" do
      expect(dispatcher.opts).to eq %w(Says Meow)
    end
  end

end
