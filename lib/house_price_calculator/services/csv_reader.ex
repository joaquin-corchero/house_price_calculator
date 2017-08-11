defmodule HousePriceCalculator.CsvReader do
    import CSV

    def get_indexes(price_request) do
        file_indexes = read(price_request)
        IO.inspect "---------------------------------"
        IO.inspect "---------------------------------"
        IO.inspect file_indexes
        IO.inspect "---------------------------------"
        IO.inspect "---------------------------------"
        cond do
            Enum.count(file_indexes) != 2 -> {:error, []}
            :true -> Enum.map(file_indexes, fn(i) -> i.index end)
        end
    end

    def read(price_request) do
        CSV.decode(File.stream!("UK-HPI-full-file-2016-05.csv"), headers: true)
        |> Stream.filter(fn({result, record}) -> 
                 result == :ok && record["RegionName"] == price_request.area && (record["Date"] == price_request.from || record["Date"] == price_request.to)
             end)
        |> Enum.take(2)
        |> Enum.map(fn({_, record}) -> record end)
    end
end