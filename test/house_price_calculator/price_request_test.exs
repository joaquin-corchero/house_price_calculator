defmodule HousePriceCalculator.PriceRequestTest do
    use ExUnit.Case
    alias HousePriceCalculator.PriceRequest, as: Sut

    describe "when converting parameters to request" do

        test ("error is returned if the parameters are not in the correct format") do
            {result, errors} = Sut.convert("something in the wrong format")
            assert result == :error
            assert errors == ["Price request input in wrong format"]
        end

        test ("when there are validation errors all of them are returned") do
            input = %{"price" => "hello", "from" => "01/01/2000", "to" => "01ir", "area" => "ad"}
            {result, errors} = Sut.convert(input)

            assert result == :error
            assert errors == [
                "Price must be a number",
                "From has invalid format MM/YYYY",
                "To has invalid format MM/YYYY",
                "Area must be longer than 2 characters"
            ]
        end

        test ("when input has correct format the correct struct is returned") do
            input = %{"price" => "100000", "from" => "02/2000", "to" => "10/2016", "area" => "islington"}
            {result, value} = Sut.convert(input)

            assert result == :ok
            assert value.price == 100000
            assert value.from == "01/02/2000"
            assert value.to == "01/10/2016"
            assert value.area == "Islington"
            
        end

        
        
    end
end