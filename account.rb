require 'json'

class Account
  attr_accessor :name, :currency, :balance, :number

  def initialize(name, currency, balance, description)
    @name = name
    @currency = currency
    @balance = balance
    @number = number
  end

  def to_json
    to_hash.to_json
  end

  def to_hash
    {
      :name => @name,
      :currency => @currency,
      :balance => @balance,
      :number => @number
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
