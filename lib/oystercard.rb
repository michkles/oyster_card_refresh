class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  attr_reader :balance, :entry_station
  def initialize
    @balance = 0
    @in_journey = false
    @entry_station
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < MINIMUM_BALANCE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} is exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
