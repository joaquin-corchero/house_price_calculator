defmodule HousePriceCalculator.PricePredictor do
    alias HousePriceCalculator.PriceResponse
    alias HousePriceCalculator.PriceCalculator

    def calculate(price_request) do

        calculated_price = PriceCalculator.calculate(10, 100, price_request.price)
        PriceResponse.create(price_request, calculated_price)
    end
end