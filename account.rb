class Account
  attr_accessor :name, :currency, :balance, :description

  def initialize(name, currency, balance, description)
    @name = name
    @currency = currency
    @balance = balance
    @description = description
  end

  def to_s()
    "**Account**:\n" +
    "-name #{name}\n" +
    "-currency #{currency}\n" +
    "-balance #{balance}\n" +
    "-description #{description}\n\n"
  end
end
