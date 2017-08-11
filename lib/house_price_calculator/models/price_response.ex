defmodule HousePriceCalculator.PriceResponse do
    
    defstruct [
        price: 0,
        from: "01/01/2000",
        to: "01/12/2016",
        area: "Somewhere",
        predicted_price: 0
    ]

    def create(price_request, predicted_price) do
        Map.put(price_request, :predicted_price, predicted_price)
    end
end