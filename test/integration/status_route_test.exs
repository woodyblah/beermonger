defmodule Beermonger.StatusRouteTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test 'the plug responds to the status GET' do
    conn = conn(:get, "/status")
    conn = Beermonger.Router.call(conn, [])

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "OK!"
  end
end