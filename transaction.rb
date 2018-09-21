require 'json'

class Transaction
  attr_accessor :date, :description, :amount

  def initialize(date, description, amount)
    @date = date
    @description = description
    @amount = amount
  end

  def to_json
    to_hash.to_json
  end

  def to_hash
    {
      :date => @date,
      :description => @description,
      :amount => @amount
    }
  end

  def to_s
    "**Transaction**:\n" +
    "-date #{date}\n" +
    "-description #{description}\n" +
    "-amount #{amount}\n"
  end
end
