defmodule HousePriceCalculator.PriceRequestTest do
    use ExUnit.Case
    alias HousePriceCalculator.PriceRequest, as: Sut

    describe "when converting parameters to request" do

        test ("error is returned if the parameters are not in the correct format") do
            {result, errors} = Sut.convert("something in the wrong format")
            assert result == :error
            assert errors == ["Price request input in wrong format"]
        end

        test ("when price is invalid error is returned") do
            input = %{"price" => "should be a number", "from" => "01/2000", "to" => "01/2016", "area" => "Islington"}
            {result, errors} = Sut.convert(input)

            assert result == :error
            assert errors == ["Price must be a number"]
        end

        # test ("when there are validation errors all of them are returned") do
        #     input = %{"price" => "hello", "from" => "01/01/2000", "to" => "01ir", "area" => "ad"}
        #     {result, errors} = Sut.convert(input)

        #     assert result == :error
        #     assert errors == [
        #         "Price must be a number",
        #         "To is invalid must have MM/YYYY format",
        #         "From is invalid must have MM/YYYY format",
        #         "Area must be larger than 2 characters"
        #     ]
        # end

        
        
    end
end