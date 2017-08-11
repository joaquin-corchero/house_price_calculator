defmodule HousePriceCalculatorWeb.PriceControllerTest do
    use HousePriceCalculatorWeb.ConnCase
    alias HousePriceCalculatorWeb.PriceController, as: Sut
    alias HousePriceCalculator.PriceRequest
    alias HousePriceCalculator.PriceResponse
    alias HousePriceCalculator.PricePredictor
    import Mock

    describe "index" do

        @valid_price_request  %{"price" => "10000", "from" => "01/2000", "to" => "01/2016", "area" => "Islington"}
        @invalid_price_request  %{"price" => "no price", "from" => "01/2000", "to" => "01/2016", "area" => "Islington"}

        test "incorrect parameters return bad request", %{conn: conn} do
            actual = Sut.index(conn, nil)
            assert actual.status == 400
            assert actual.resp_body == "[\"Incorrect parameters, try api/price?price=100000&from=01/2000&to=01/2016&area=Islington\"]"
        end

        test "if the params are invalid errors from price input convert are returned", %{conn: conn} do
            with_mock(PriceRequest, [convert: fn(_params) -> {:error, ["some errors"]} end]) do
                actual = Sut.index(conn, @invalid_price_request)
                assert actual.status == 400
                assert actual.resp_body == "[\"some errors\"]"
            end
        end

        test "unsuccessful calculation returns error", %{conn: conn} do
            conversion_result = %PriceRequest{ price: 100000, from: "01/01/2000", to: "01/12/2016", area: "Islington"}
            price_response = ["Some more errors"]

            with_mock(PriceRequest, [convert: fn(_params) -> {:ok, conversion_result} end]) do
                with_mock(PricePredictor, [calculate: fn(conversion_result) -> {:error, price_response} end]) do
                    actual = Sut.index(conn, @valid_price_request)
                    assert actual.status == 400
                    assert actual.resp_body == "[\"Some more errors\"]"
                end
            end
        end

        test "successful calculation returns ok and a response", %{conn: conn} do
            conversion_result = %PriceRequest{ price: 100000, from: "01/01/2000", to: "01/12/2016", area: "Islington"}
            price_response = %PriceResponse{price: 10000, from: "01/01/2000", to: "01/01/2016", area: "Islington", predicted_price: 200000}

            with_mock(PriceRequest, [convert: fn(_params) -> {:ok, conversion_result} end]) do
                with_mock(PricePredictor, [calculate: fn(conversion_result) -> {:ok, price_response} end]) do
                    actual = Sut.index(conn, @valid_price_request)
                    assert actual.status == 200
                    assert actual.resp_body == "{\"to\":\"01/01/2016\",\"price\":10000,\"predicted_price\":200000,\"from\":\"01/01/2000\",\"area\":\"Islington\"}"
                end
            end
        end
    
    end

end