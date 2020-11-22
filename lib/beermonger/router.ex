defmodule Beermonger.Router do
  @moduledoc """
  A plug responsible for path matching and request routing
  """

  use Plug.Router

  @public_files_path Application.get_env(:beermonger, :public_files_path)
  @products_gateway Application.get_env(:beermonger, :products_gateway)

  # This module is a Plug, that also implements it's own plug pipeline, below:

  # responsible for matching routes
  plug(:match)
  # responsible for dispatching responses
  plug(:dispatch)


  # A simple route to test that the server is up
  get "/status" do
    send_resp(conn, 200, "OK!")
  end

  get "/products/:style" do
    conn = conn
           |> fetch_query_params()
           |> put_resp_content_type("application/json")

    send_resp(conn, 200, Poison.encode!(Beermonger.Products.products_list(@products_gateway, style, sort_by(conn.query_params), asc?(conn.query_params))))
  end

  get "/products" do
    conn = conn
           |> fetch_query_params()
           |> put_resp_content_type("application/json")

    send_resp(conn, 200, Poison.encode!(Beermonger.Products.products_list(@products_gateway, nil, sort_by(conn.query_params), asc?(conn.query_params))))
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

  #UI routes
  get "/", do: send_file(conn, 200, "#{@public_files_path}index.html")
  get "/css/styles.css", do: send_file(conn, 200, "#{@public_files_path}css/styles.css")
  get "/js/scripts.js", do: send_file(conn, 200, "#{@public_files_path}js/scripts.js")

  match _, do: send_resp(conn, 404, "404 - Not Found")
end