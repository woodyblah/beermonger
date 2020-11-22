use Mix.Config

config :beermonger,
  products_gateway: Beermonger.Mocks.MixedProductsList,
  public_files_path: "public/"