defmodule HousePriceCalculator.PriceRequest do
    
    defstruct [
        price: 0,
        from: "01/01/2000",
        to: "01/12/2016",
        area: "Somewhere"
    ]

    def convert(%{"price" => price, "from" => from, "to" => to, "area" => area} = params) do
        process_validations(
            [
                validate_price(price), 
                validate_date(from, "From"),
                validate_date(to, "To"),
                validate_area(area)
            ]
        )
    end
    def convert(_) do
        {:error, ["Price request input in wrong format"]}
    end

    defp process_validations([{:ok, price}, {:ok, from}, {:ok, to}, {:ok, area}]) do
        {
            :ok, 
            %__MODULE__{
                price: price,
                from: from,
                to: to,
                area: area
            }
        }
    end    
    defp process_validations(validation_results) do
        errors = validation_results
            |> Enum.filter(fn({result, error_or_value}) -> result == :error end)
            |> Enum.map(fn({_, error}) -> error end)

        {:error, errors}
    end

    defp validate_price(price) do
        {number, string_part} = Float.parse(price)
        cond do
            String.length(string_part) == 0 -> {:ok, number}
            true -> {:error, "Price must be a number"}
        end
    end
    
    defp validate_date(date, field_name) do
        date = "01/" <> date
        {result, _} = Timex.parse(date, "{D}/{0M}/{YYYY}")
        cond do
            result == :ok -> {:ok, date}
            true -> {:error, field_name <> " has invalid format MM/YYYY" }
        end
    end
    
    defp validate_area(area), do: {:ok, area}
    
end