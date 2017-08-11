defmodule HousePriceCalculatorWeb.Router do
  use HousePriceCalculatorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HousePriceCalculatorWeb do
    pipe_through :api

    get "/prices", PriceController, :index
  end
end
