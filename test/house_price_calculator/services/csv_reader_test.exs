defmodule HousePriceCalculator.CsvReaderTests do
    use ExUnit.Case
    alias HousePriceCalculator.PriceRequest
    alias HousePriceCalculator.CsvReader, as: Sut
    import Mock
    import CSV

    @price_request %PriceRequest{
        price: 100000,
        from: "01/02/2000",
        to: "01/10/2016",
        area: "Islington"
    }

    describe "When working with the csv reader" do
       
        test "error is returned when no indexes are found" do
            with_mock CSV, [decode: fn(_stream) -> [] end] do
                {result, indexes} = Sut.get_indexes(@price_request)

                assert result == :error
                assert indexes == []
            end
        end
    end
end