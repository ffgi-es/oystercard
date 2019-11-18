require 'oystercard'

describe Oystercard do
  context "Initialised card" do
    it "should have a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end
end
