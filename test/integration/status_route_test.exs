defmodule Beermonger.StatusRouteTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "the plug responds to the status GET" do
    conn = conn(:get, "/status")
    conn = Beermonger.Router.call(conn, [])

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "OK!"
  end

  test "the plug responds to unknown routes with a 404" do
    conn = conn(:get, "/fake")
    conn = Beermonger.Router.call(conn, [])

    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "404 - Not Found"
  end
end