defmodule Beermonger.ProductsRouteTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test 'getting a list of vegetables returns an empty JSON list' do
    conn = conn(:get, "/products/vegetable")
    conn = Beermonger.Router.call(conn, [])

    expected_products = []

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == Poison.encode!(expected_products)
  end

  test 'getting a list of beers returns a JSON list of beers' do
    conn = conn(:get, "/products/beer")
    conn = Beermonger.Router.call(conn, [])

    expected_products = [
      %{
        name: "Double IPA",
        image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
        style: "beer",
        price: 12.99
      },
      %{
        name: "Wheat Beer",
        image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
        style: "beer",
        price: 7.49
      }
    ]

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == Poison.encode!(expected_products)
  end

  test 'getting a list of cider returns a JSON list of ciders' do
    conn = conn(:get, "/products/cider")
    conn = Beermonger.Router.call(conn, [])

    expected_products = [
      %{
        name: "Dry Cider",
        image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
        style: "cider",
        price: 6.99
      }
    ]

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == Poison.encode!(expected_products)
  end
end