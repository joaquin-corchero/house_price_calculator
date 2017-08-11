defmodule HousePriceCalculator.PricePredictorTest do
    use ExUnit.Case
    alias HousePriceCalculator.PricePredictor, as: Sut
    alias HousePriceCalculator.PriceRequest
    alias HousePriceCalculator.PriceCalculator
    import Mock

    @price_request %PriceRequest{
        price: 100000,
        from: "01/02/2000",
        to: "01/10/2016",
        area: "Islington"
    }

    @predicted_price 200000

    describe "when using the price predictor" do

        test "the price calculator is called" do
            with_mock(PriceCalculator, [calculate: fn(_from_index, _to_index, _proce) -> @predicted_price end]) do
                actual = Sut.calculate(@price_request)
                expected =  {:ok, Map.put(@price_request, :predicted_price, @predicted_price)}

                assert called PriceCalculator.calculate(10, 100, @price_request.price)
                assert actual == expected
            end
        end

    end
end

