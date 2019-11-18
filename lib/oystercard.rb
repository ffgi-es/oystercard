class Oystercard
  BALANCE_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise top_up_amount_error(amount) unless amount > 0
    total = amount + @balance
    raise balance_limit_error(total) if total > BALANCE_LIMIT

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def balance_limit_error total
    message = "Over balance limit (#{total}/#{BALANCE_LIMIT})"
    BalanceError.new(message)
  end

  def top_up_amount_error amount
    message = "Cannot top up with amount of #{amount}"
    InvalidOperationError.new(message)
  end
end

class BalanceError < StandardError
end

class InvalidOperationError < StandardError
end