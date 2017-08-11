defmodule HousePriceCalculator.PriceResponse do
    
    defstruct [
        price: 0,
        from: "01/01/2000",
        to: "01/12/2016",
        area: "Somewhere",
        predicted_price: 0,
        indexes: []
    ]

    def create(price_request, predicted_price, indexes) do
        result = price_request
            |> Map.put(:predicted_price, predicted_price)
            |> Map.put(:indexes, indexes)
        
        {:ok, result}
    end
end