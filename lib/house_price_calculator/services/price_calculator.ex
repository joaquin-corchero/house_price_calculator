defmodule HousePriceCalculator.PriceCalculator do

    def calculate(indexes, price) do
        to = Enum.at(indexes, 0)
        from = Enum.at(indexes, 1)
        price * (from / to)
    end
end