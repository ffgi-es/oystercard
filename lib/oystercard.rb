class Oystercard
  BALANCE_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    total = amount + @balance
    raise balance_limit_error(total) if total > BALANCE_LIMIT

    @balance += amount
  end

  private

  def balance_limit_error total
    message = "Over balance limit (#{total}/#{BALANCE_LIMIT})"
    BalanceError.new(message)
  end
end

class BalanceError < StandardError
end
