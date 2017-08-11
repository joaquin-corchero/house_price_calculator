defmodule HousePriceCalculator.PricePredictor do
    alias HousePriceCalculator.PriceResponse
    alias HousePriceCalculator.PriceCalculator
    alias HousePriceCalculator.CsvReader

    def calculate(price_request) do
        {result, indexes} = CsvReader.get_indexes(price_request)
        cond do
            result == :error -> {:error, ["One or both of the indixes required for the calculation couldn't be found"]}
            :true -> execute_calculation(price_request, indexes)
        end
    end

    defp execute_calculation(price_request, indexes) do
        calculated_price = PriceCalculator.calculate(indexes, price_request.price)
        PriceResponse.create(price_request, calculated_price, indexes)
    end
end