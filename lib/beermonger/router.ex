defmodule Beermonger.Router do
  @moduledoc """
  A plug responsible for path matching and request routing
  """

  use Plug.Router

  # This module is a Plug, that also implements it's own plug pipeline, below:

  # responsible for matching routes
  plug(:match)
  # Using Poison for JSON decoding
  # Note, order of plugs is important, by placing this _after_ the 'match' plug,
  # we will only parse the request AFTER there is a route match.
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  # responsible for dispatching responses
  plug(:dispatch)

  @products_gateway Application.get_env(:beermonger, :products_gateway)

  # A simple route to test that the server is up
  get "/status" do
    send_resp(conn, 200, "OK!")
  end

  get "/products/:style" do
    conn = put_resp_content_type(conn, "application/json")
    send_resp(conn, 200, Poison.encode!(Beermonger.Products.products(@products_gateway, style)))
  end
end