defmodule HousePriceCalculator.CsvReaderTests do
    use ExUnit.Case
    alias HousePriceCalculator.PriceRequest
    alias HousePriceCalculator.CsvReader, as: Sut
    import Mock
    import CSV

    @price_request %PriceRequest{
        price: 100000,
        from: "01/02/2004",
        to: "01/03/2004",
        area: "Islington"
    }
    @price_request_for_single_result %PriceRequest{
        price: 100000,
        from: "01/01/2004",
        to: "01/03/2004",
        area: "Leyton"
    }
    
    @file_content  [
      error: %{"Date" => "01/01/2004", "RegionName" => "Leyton", "Index" => "40.86421361"},
      ok: %{"Date" => "01/02/2004", "RegionName" => "Islington", "Index" => "40.85675677"},
      ok: %{"Date" => "01/03/2004", "RegionName" => "Islington", "Index" => "41.7803169"},
      ok: %{"Date" => "01/03/2004", "RegionName" => "Leyton", "Index" => "41.7803169"}
    ]

    describe "When working with the csv reader" do
       
        test "error is returned when no indexes are found" do
            with_mock CSV, [decode: fn(_stream, _options) -> [] end] do
                {result, indexes} = Sut.get_indexes(@price_request)

                assert result == :error
                assert indexes == []
            end
        end

        test "error is returned when 1 index is found" do
            with_mock CSV, [decode: fn(_stream, _options) -> @file_content end] do
                {result, indexes} = Sut.get_indexes(@price_request_for_single_result)

                assert result == :error
                assert indexes == []
            end
        end
    end
end