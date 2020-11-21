defmodule Beermonger.Mocks.NotFound do
  def get(_), do: {:ok, %{status_code: 404}}
end

defmodule Beermonger.Mocks.InternalServerError do
  def get(_), do: {:ok, %{status_code: 500}}
end

defmodule Beermonger.Mocks.ConnectionRefused do
  def get(_), do: {:error, %{reason: :econnrefused}}
end

defmodule Beermonger.Mocks.EmptyListSuccessfulResponse do
  def get(_), do: {:ok, %{status_code: 200, body: Poison.encode!([])}}
end

defmodule Beermonger.Mocks.MixedListSuccessfulResponse do
  def get(_) do
    products = [
      %{
        name: "Double IPA",
        image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
        style: "beer",
        price: 12.99
      },
      %{
        name: "Dry Cider",
        image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
        style: "cider",
        price: 6.99
      },
      %{
        name: "Wheat Beer",
        image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
        style: "beer",
        price: 7.49
      },
    ]

    {:ok, %{status_code: 200, body: Poison.encode!(products)}}
  end
end