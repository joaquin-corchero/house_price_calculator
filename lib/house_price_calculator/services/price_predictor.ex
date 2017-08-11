defmodule HousePriceCalculator.PricePredictor do
    alias HousePriceCalculator.PriceResponse

    def calculate(request_input) do
        PriceResponse.create(request_input, 200000)
    end
end