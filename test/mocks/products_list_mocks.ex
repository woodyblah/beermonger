defmodule Beermonger.Mocks.EmptyProductsList do
  def get_all_products(_) do
    []
  end
end

defmodule Beermonger.Mocks.OnlyOneBeerProductsList do
  def get_all_products(_) do
    [
      %{
        name: "Double IPA",
        image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
        style: "beer",
        price: 12.99
      }
    ]
  end
end

defmodule Beermonger.Mocks.MixedProductsList do
  def get_all_products(_) do
    [
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
  end
end