defmodule HousePriceCalculatorWeb.PriceController do
    use HousePriceCalculatorWeb, :controller
    alias HousePriceCalculator.PriceRequest
    alias HousePriceCalculator.PricePredictor

    def index(conn, %{"price" => price, "from" => from, "to" => to, "area" => area} = params) do
        {result, conversion_output} = PriceRequest.convert(params)
        cond do
            result == :error -> conn |> return_errors conversion_output
            true -> conn |> process_request conversion_output
        end
    end

    def index(conn, _) do
        conn |>
        return_errors ["Incorrect parameters, try api/price?price=100000&from=01/2000&to=01/2016&area=Islington"]
    end

    defp return_errors(conn, error_list) do
        json(conn |> put_status(400), error_list)
    end

    defp process_request(conn, input) do
        {result, calculation_result} = PricePredictor.calculate(input)
        cond do
            result == :error -> conn |> return_errors calculation_result
            true -> conn |> put_status(200) |> json calculation_result
        end
    end
end