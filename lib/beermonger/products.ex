defmodule Beermonger.Products do

  @http_client HTTPoison

  def products_list_by_style(products_gateway, style) do
    products_gateway.get_all_products(@http_client)
    |> Enum.filter(fn %{style: s} -> s == style end)
  end

  def single_product_by_price(products_gateway, "cheapest") do
    products_gateway.get_all_products(@http_client)
    |> Enum.min_by(fn %{price: p} -> p end, fn -> %{} end)
  end

  def single_product_by_price(products_gateway, "most_expensive") do
    products_gateway.get_all_products(@http_client)
    |> Enum.max_by(fn %{price: p} -> p end, fn -> %{} end)
  end

  def single_product_by_price(_products_gateway, _invalid_filter), do: %{}
end