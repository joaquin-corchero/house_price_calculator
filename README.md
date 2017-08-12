# HousePriceCalculator

## To make it run:
- You will need Elixir version 1.4.
- Download the file: http://publicdata.landregistry.gov.uk/market-trend-data/house-price-index-data/UK-HPI-full-file-2016-05.csv  and place it on the house_price_calculator root directory
- Go to the command line
- Clone the repo
- Go to the house_price_calculator directory and type mix deps.get, that will download all the dependencies
- You can run the tests by running mix test
- Run the api by typing mix phx.server
- Go to http://localhost:4000/api/prices?price=100000&from=01/2000&to=01/2016&area=islington and you should see some results.

## What is missing:
- CSV reader doesn't seem to perform too well, will depend on your machine.
- Was thinking of using Agents to keep the contents of the CSV in state, but not enough time.


## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
