require 'spec_helper'

describe Ynabify::Utility do
  context "#constantize" do
    it "should convert string into constant" do
      class ::Meow; end;

      expect("Meow".constantize).to eq(::Meow)
    end

    it "should handle namespaces" do
      class Ynabify::Meow; end;

      expect("Ynabify::Meow".constantize).to eq(Ynabify::Meow)
    end
  end

end


describe String do
  context "#camelize" do
    it "should convert from snake case to camel case" do
      expect("meow_meow_meow".camelize).to eq("MeowMeowMeow")
    end
  end

  context "#constantize" do
    it "should call Ynabify::Utility.constantize with itself as arg" do
      expect( Ynabify::Utility ).to receive(:constantize)

      "MeowMeowMeow".constantize
    end
  end
end
