defmodule Beermonger.Products do

  @http_client HTTPoison

  def products(products_gateway, style) do
    products_gateway.get_all_products(@http_client)
    |> Enum.filter(fn %{style: s} -> s == style end)
  end
end