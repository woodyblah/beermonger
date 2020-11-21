defmodule Beermonger.ProductsGatewayTest do
  use ExUnit.Case

  describe "get_all_products/1" do
    test "given an HTTP client returning a 404 it returns an empty list" do
      assert Beermonger.ProductsGateway.get_all_products(Beermonger.Mocks.NotFound) == []
    end

    test "given an HTTP client returning an error it returns an empty list" do
      assert Beermonger.ProductsGateway.get_all_products(Beermonger.Mocks.InternalServerError) == []
    end

    test "given an HTTP client that cannot reach the desired endpoint it returns an empty list" do
      assert Beermonger.ProductsGateway.get_all_products(Beermonger.Mocks.ConnectionRefused) == []
    end

    test "given a successful but empty response from the API endpoint it returns an empty list" do
      assert Beermonger.ProductsGateway.get_all_products(Beermonger.Mocks.EmptyListSuccessfulResponse) == []
    end

    test "given a successful response with content it returns the products list" do
      expected_products = [
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


      assert Beermonger.ProductsGateway.get_all_products(
               Beermonger.Mocks.MixedListSuccessfulResponse
             ) == expected_products
    end

    # todo JSON decoding error
    # todo valid JSON but invalid data structure
    # todo implement logging
  end
end