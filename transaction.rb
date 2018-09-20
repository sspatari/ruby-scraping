require 'json'

class Transaction
  attr_accessor :name, :description, :amount

  def initialize(name, description, amount)
    @name = name
    @description = description
    @amount = amount
  end

  def to_json
    to_hash.to_json
  end

  def to_hash
    {
      :name => @name,
      :description => @description,
      :amount => @amount
    }
  end

  def to_s
    "**Transaction**:\n" +
    "-name #{name}\n" +
    "-description #{description}\n" +
    "-amount #{amount}\n\n"
  end
end
