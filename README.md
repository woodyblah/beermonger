[![Build Status](https://travis-ci.com/woodyblah/beermonger.svg?branch=main)](https://travis-ci.com/woodyblah/beermonger)

# Beermonger

Beermonger is a REST API and Web UI built on top of the data made available at http://api.eebria.com

The backend code is available inside the `lib` directory, most of te business logic lives in `products.ex`.
The specs for this are in the `test` directory

The frontend code is available in the `public` directory

### GET endpoints
`/products` for getting a list of all the products 

`/products/beer` and `/products/cider` for getting only a list of the beer or cider products

There are query string parameters for this route for sorting and ordering, e.g
```
/products?sortBy=name # all products sorted alphabetically
/products/beer?sortBy=price&orderBy=desc # all beers ordered by price, most expensive first 
```


`/product/cheapest` for getting the cheapest listed item

`product/most_expensive` for getting the most expensive listed item

### Web interface

Served at `/` there is a web interface that consumes the above API methods and privides some basic user interaction to adjust the filtering and sorting of the list of products. You can change the list sorting by clicking on the table headers.

### Running locally

To build and run the app locally you will need Elixir v1.11, details on installing this can be found [here](https://elixir-lang.org/install.html)

Once elixir is installed simply run `mix run --no-halt` to run the application in development mode, it should become accessible at http://localhost:8080

To run the unit tests run: `mix test`

### Deployed installation

I have deployed the application to an EC2 instance for the purposes of demonstration, it is available at:

[http://ec2-18-217-54-98.us-east-2.compute.amazonaws.com/](http://ec2-18-217-54-98.us-east-2.compute.amazonaws.com/)

