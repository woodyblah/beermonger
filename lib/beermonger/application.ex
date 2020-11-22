defmodule Beermonger.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Beermonger.Router,
        options: [port: port(args)]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Beermonger.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp port(env: :prod), do: 80
  defp port(env: :dev), do: 8080
  defp port(_args), do: 8888
end
