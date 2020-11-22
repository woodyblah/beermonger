loadSingleProduct = function(type) {
    $.get(`product/${type}`, function(product_data) {
        $(`#${type}_product`).prepend(`<img src="${product_data.image}">`);
        $(`#${type}_product .name`).text(product_data.name);
        $(`#${type}_product .style`).text(product_data.style);
        $(`#${type}_product .price`).text(product_data.price);
    });
};

productsListTableRow = function(product_data) {
    return `
    <tr>
        <td><img src="${product_data.image}"></td>
        <td>${product_data.name}</td>
        <td>${product_data.style}</td>
        <td>${product_data.price}</td>
    </tr>
    `
};

loadProductsList = function() {
    $.get('products', function(products_list) {
        products_list.forEach(function(product) {
            $("#products_list table tbody").append(productsListTableRow(product));
        });
    });
};

$( document ).ready(function(){
    loadSingleProduct("cheapest");
    loadSingleProduct("most_expensive");
    loadProductsList();
});