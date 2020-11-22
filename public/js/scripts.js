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

loadProductsList = function(path) {
    $.get(path, function(products_list) {
        var new_table = '';
        products_list.forEach(function(product) { new_table += productsListTableRow(product);});
        $("#products_list table tbody").html(new_table)
    });
};

var currentSort = null;
var currentOrder = null;

capitalise = function(string) { return string.charAt(0).toUpperCase() + string.slice(1) };

sortTable = function(attribute) {
    if (currentSort !== null) {
        $(`#products_list_${currentSort}_header`).text(`${capitalise(currentSort)}`);
    }
    if(attribute === currentSort && currentOrder !== "desc") {
        loadProductsList(`products?sortBy=${attribute}&orderBy=desc`);
        $(`#products_list_${attribute}_header`).text(`${capitalise(attribute)} ▼`);
        currentOrder = "desc";
    } else {
        loadProductsList(`products?sortBy=${attribute}`);
        $(`#products_list_${attribute}_header`).text(`${capitalise(attribute)} ▲`);
        currentSort = attribute;
        currentOrder = "asc";
    }
};

$( document ).ready(function(){
    loadSingleProduct("cheapest");
    loadSingleProduct("most_expensive");
    loadProductsList("products");
});