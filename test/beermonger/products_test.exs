defmodule Beermonger.ProductsTest do
  use ExUnit.Case

  describe "products/2" do
    test "given an empty data store it returns an empty list of products for the given style" do
      assert Beermonger.Products.products_list_by_style(Beermonger.Mocks.EmptyProductsList, "beer") == []
    end

    test "given a populated data store it returns an empty list of products for a style that does not appear in the list" do
      assert Beermonger.Products.products_list_by_style(Beermonger.Mocks.MixedProductsList, "vegetable") == []
    end

    test "given a data store populated only with beers it returns an empty list of products for ciders" do
      assert Beermonger.Products.products_list_by_style(Beermonger.Mocks.OnlyOneBeerProductsList, "cider") == []
    end

    test "given a data store containing only one beer, this item is returned when requesting a list of beers" do
      assert Beermonger.Products.products_list_by_style(Beermonger.Mocks.OnlyOneBeerProductsList, "beer") == [
               %{
                 name: "Double IPA",
                 image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
                 style: "beer",
                 price: 12.99
               }
             ]
    end

    test "given a data store containing many products, only beers item are returned when requesting a list of beers" do
      assert Beermonger.Products.products_list_by_style(Beermonger.Mocks.MixedProductsList, "beer") == [
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
    end

    test "given a data store containing many products, only cider item are returned when requesting a list of ciders" do
      assert Beermonger.Products.products_list_by_style(Beermonger.Mocks.MixedProductsList, "cider") == [
               %{
                 name: "Dry Cider",
                 image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
                 style: "cider",
                 price: 6.99
               }
             ]
    end
  end

  describe "single_product_by_price/2" do
    test "given an empty data store it returns an empty object" do
      assert Beermonger.Products.single_product_by_price(Beermonger.Mocks.EmptyProductsList, "cheapest") == %{}
    end

    test "given a filled data store, but an invalid filter option it returns an empty object" do
      assert Beermonger.Products.single_product_by_price(Beermonger.Mocks.MixedProductsList, "hardest") == %{}
    end

    test "given a filled data store, and a cheapest filter, it returns the cheapest item" do
      assert Beermonger.Products.single_product_by_price(Beermonger.Mocks.MixedProductsList, "cheapest") == %{
               name: "Dry Cider",
               image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
               style: "cider",
               price: 6.99
             }
    end

    test "given a filled data store, and a most_expensive filter, it returns the most expensive item" do
      assert Beermonger.Products.single_product_by_price(Beermonger.Mocks.MixedProductsList, "most_expensive") == %{
               name: "Double IPA",
               image: "https://www.eebria.com/assets/images/v3/icons/suggestion-tool.png",
               style: "beer",
               price: 12.99
             }
    end
  end
end