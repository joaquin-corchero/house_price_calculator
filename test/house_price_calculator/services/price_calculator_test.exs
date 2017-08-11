defmodule HousePriceCalculator.PriceCalculatorTests do
    use ExUnit.Case
    alias HousePriceCalculator.PriceCalculator, as: Sut

    @indexes [28.25, 103.60]
    @price 100_000

    describe "when calculating the price" do

        test "the price gets calculated correctly" do
            actual = Sut.calculate(@indexes, @price) |>
                Float.ceil()

            assert actual == 366_726.0
        end
    end
end