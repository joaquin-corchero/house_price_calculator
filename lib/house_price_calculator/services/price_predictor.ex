defmodule HousePriceCalculator.PricePredictor do
    alias HousePriceCalculator.PriceResponse

    def calculate(price_request) do
        


        calculated_price = 200000
        PriceResponse.create(price_request, calculated_price)
    end
end