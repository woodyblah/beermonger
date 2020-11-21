defmodule Beermonger.ProductRouteTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test 'getting the cheapest product returns the dry cider' do
    conn = conn(:get, "/product/cheapest")
    conn = Beermonger.Router.call(conn, [])

    expected_product = %{
      name: "Dry Cider",
      image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
      style: "cider",
      price: 6.99
    }

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == Poison.encode!(expected_product)
  end

  test 'getting the most_expensive product returns the double IPA' do
    conn = conn(:get, "/product/most_expensive")
    conn = Beermonger.Router.call(conn, [])

    expected_product = %{
      name: "Double IPA",
      image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
      style: "beer",
      price: 12.99
    }

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == Poison.encode!(expected_product)
  end

  test 'using an inccorect filter causes a 404' do
    conn = conn(:get, "/product/most_delicious")
    conn = Beermonger.Router.call(conn, [])

    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "404 - Not Found"
  end
end