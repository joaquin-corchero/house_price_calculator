defmodule HousePriceCalculator.PriceRequest do
    
    defstruct [
        price: 0,
        from: "01/01/2000",
        to: "01/12/2016",
        area: "Somewhere"
    ]

    def convert(%{"price" => price, "from" => from, "to" => to, "area" => area} = params) do
        
    end

    def convert(_) do
        {:error, ["Price request input in wrong format"]}
    end
end