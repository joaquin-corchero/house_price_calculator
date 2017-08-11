defmodule HousePriceCalculator.PriceRequestTest do
    use ExUnit.Case
    alias HousePriceCalculator.PriceRequest, as: Sut

    describe "when converting parameters to request" do

        test ("error is returned if the parameters are not in the correct format") do
            {result, errors} = Sut.convert("something in the wrong format")
            assert result == :error
            assert errors == ["Price request input in wrong format"]
        end
        
    end
end