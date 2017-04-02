require 'oystercard'

describe Oystercard do
  it 'has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance ' do
      expect { subject.top_up(20).to change { subject.balance }.by 20 }
    end

    it 'raises an error if the maximum balance is exceeded' do
      max_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up 1}.to raise_error "Maximum balance of #{max_balance} is exceeded"
    end
  end

  describe '#deduct' do

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'can deduct the money from balance' do
      subject.top_up(20)
      expect { subject.deduct(10) }.to change { subject.balance }.by -10 
    end
  end
end
