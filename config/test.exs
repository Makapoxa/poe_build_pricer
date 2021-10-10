import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :poe_build_pricer_elixir, PoeBuildPricerWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "lzV39eRwGxiezzUfzde+cjUn+ymQkfCe62g9MdjiA8MHfXxiiNPdI+RlV0so1Rsd",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
