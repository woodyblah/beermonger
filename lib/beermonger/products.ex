defmodule Beermonger.Products do
  def products(products_gateway, style) do
    products_gateway.get_all_products()
    |> Enum.filter(fn %{style: s} -> s == style end)
  end
end