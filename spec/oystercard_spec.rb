require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }

  context "Initialised card" do
    it "should have a balance of 0" do
      expect(subject.balance).to eq 0
    end
    it "should not be in a journey" do
      expect(card).to_not be_in_journey
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

    specify "that it raises an error when the amount isn't greater than 0" do
      expect{card.top_up -1}.to raise_error InvalidOperationError, "Cannot top up with amount of -1"
      expect{card.top_up 0}.to raise_error InvalidOperationError, "Cannot top up with amount of 0"
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
  context 'an oystercard with money on it' do
    before { card.top_up 40 }
    describe '#deduct' do
      it 'should decrease the balance' do
        card.deduct 5 
        expect(card.balance).to eq 35
      end
    end
    context 'going on a journey' do
      it 'should be possible to touch in' do
        card.touch_in
        expect(card.in_journey?).to eq true
      end
      it 'should be possible to touch_out' do
        card.touch_in
        card.touch_out
        expect(card.in_journey?).to eq false
      end
    end
  end
end
