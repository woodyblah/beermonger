defmodule Beermonger.Router do
  @moduledoc """
  A plug responsible for path matching and request routing
  """

  use Plug.Router

  # This module is a Plug, that also implements it's own plug pipeline, below:

  # responsible for matching routes
  plug(:match)
  # responsible for dispatching responses
  plug(:dispatch)

  @products_gateway Application.get_env(:beermonger, :products_gateway)

  # A simple route to test that the server is up
  get "/status" do
    send_resp(conn, 200, "OK!")
  end
  get "/products/:style" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(Beermonger.Products.products_list_by_style(@products_gateway, style)))
  end

  get "/products" do
    conn = conn
    |> fetch_query_params()
    |> put_resp_content_type("application/json")

    send_resp(conn, 200, Poison.encode!(Beermonger.Products.products_list_sorted_by_attribute(@products_gateway, sort_by(conn.query_params), asc?(conn.query_params))))
  end

  defp sort_by(%{"sortBy" => attribute}), do: attribute
  defp sort_by(_params), do: "name"

  defp asc?(%{"orderBy" => "desc"}), do: false
  defp asc?(_params), do: true

  @acceptable_filters ["cheapest", "most_expensive"]

  get "/product/:filter" do
    if Enum.member?(@acceptable_filters, filter) do
      conn = put_resp_content_type(conn, "application/json")
      send_resp(conn, 200, Poison.encode!(Beermonger.Products.single_product_by_price(@products_gateway, filter)))
    else
      send_resp(conn, 404, "404 - Not Found")
    end
  end

  match _, do: send_resp(conn, 404, "404 - Not Found")
end