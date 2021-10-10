defmodule PoeBuildPricerWeb.Router do
  use PoeBuildPricerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PoeBuildPricerWeb do
    pipe_through :api
  end
end
