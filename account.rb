require 'json'

class Account
  attr_accessor :name, :currency, :balance, :number, :transactions

  def initialize(name, currency, balance, number)
    @name = name
    @currency = currency
    @balance = balance
    @number = number
    @transactions = []
  end

  def to_json
    to_hash.to_json
  end

  def to_hash
    {
      :name => @name,
      :currency => @currency,
      :balance => @balance,
      :number => @number,
      :transactions => @transactions.map { |transaction| transaction.to_hash}
    }
  end

  def to_s
    "**Account**:\n" +
    "-name #{name}\n" +
    "-currency #{currency}\n" +
    "-balance #{balance}\n" +
    "-number #{number}\n\n"
  end
end
