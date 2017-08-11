defmodule HousePriceCalculator.PricePredictorTest do
    use ExUnit.Case
    alias HousePriceCalculator.PricePredictor, as: Sut
    alias HousePriceCalculator.PriceRequest
    alias HousePriceCalculator.PriceCalculator
    alias HousePriceCalculator.CsvReader
    import Mock

    @price_request %PriceRequest{
        price: 100000,
        from: "01/02/2000",
        to: "01/10/2016",
        area: "Islington"
    }

    @predicted_price 200000

    describe "when using the price predictor" do

        test "if the indexes are not returned from the csv reader error is returned" do
            with_mock(CsvReader, [get_indexes: fn(_) -> {:error, []} end]) do
                {result, errors} = Sut.calculate(@price_request)

                assert called CsvReader.get_indexes(@price_request)
                assert result == :error;
                assert errors == ["One or both of the indixes required for the calculation couldn't be found"]
            end
        end


        test "the price calculator is called" do
            indexes = [10, 100]
            with_mock(CsvReader, [get_indexes: fn(@price_request) -> {:ok, indexes} end]) do
                with_mock(PriceCalculator, [calculate: fn(_indexes, _price) -> @predicted_price end]) do
                    actual = Sut.calculate(@price_request)
                    expected =  {:ok, Map.put(@price_request, :predicted_price, @predicted_price)}

                    assert called PriceCalculator.calculate(indexes, @price_request.price)
                    assert actual == expected
                end
            end
        end

    end
end

