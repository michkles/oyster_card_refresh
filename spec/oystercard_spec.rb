require 'oystercard'

describe Oystercard do

  it 'has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'is initially not in a jounrey' do
    expect(subject).not_to be_in_journey
  end

  describe "#touch_in" do

    it 'can touch.in' do
      subject.top_up(10)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'will not touch in if below minimun balance' do
      expect { subject.touch_in }.to raise_error "Insufficient balance to touch in"
    end
  end

  describe "#touch_out" do

    it "will dedect money on touch_out" do
      subject.top_up(10)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end
  end

  describe "#top_up" do
    before do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
    end

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance ' do
      expect { subject.top_up(20).to change { subject.balance }.by 20 }
    end

    it 'raises an error if the maximum balance is exceeded' do
      expect { subject.top_up 1}.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} is exceeded"
    end
  end

end
