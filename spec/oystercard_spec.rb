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

    context "When balance limit is reached" do
      it "should raise an error if the amount is over the limit" do
        expect { card.top_up 91 }.to raise_error BalanceError, "Over balance limit (91/90)"
      end

      it "should raise an error if the balance would go over the limit" do
        card.top_up 50
        expect { card.top_up 50 }.to raise_error BalanceError, "Over balance limit (100/90)"
      end
    end
  end
end
