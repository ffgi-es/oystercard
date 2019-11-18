require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  context "Initialised card" do
    it "should have a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end
  describe "#top_up" do
    specify "that top up increases the balance" do
      card.top_up 1
      expect(card.balance).to eq 1
    end
    specify "that multiple top ups are recorded" do
      card.top_up 1
      card.top_up 2
      expect(card.balance).to eq 3
    end
  end
end
