defmodule Beermonger.ProductsGateway do

  @api_endpoint "http://api.eebria.com/"

  def get_all_products(http_client) do
    case http_client.get(@api_endpoint) do
      {:ok, %{status_code: 200, body: body}} ->
        Poison.decode!(body, %{keys: :atoms})
      _ ->
        []
    end
  end
end