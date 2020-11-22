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
        // replace whole table at once to avoid visual glitches due to slow responses
        $("#products_list table tbody").html(new_table)
    });
};

let currentFilter = null;
let currentSort = null;
let currentOrder = null;

filterBy = function(style) {
    var path = '';
    if (currentFilter === null) {
        currentFilter = style;
        path = `products/${style}`
    } else if (currentFilter === style) {
        currentFilter = null;
        path = `products`
    } else {
        $(`#${currentFilter}_filter`).prop("checked", false);
        currentFilter = style;
        path = `products/${style}`
    }
    // keep current sorting
    if (currentSort !== null) {
        path += `?sortBy=${currentSort}`
        if (currentOrder === 'desc') {
            path += `&orderBy=desc`
        }
    }
    loadProductsList(path)
};

capitalise = function(string) { return string.charAt(0).toUpperCase() + string.slice(1) };

sortTable = function(attribute) {
    // keep current sorting
    path = (currentFilter === null) ? 'products' : `products/${currentFilter}`;
    // remove sorting visual queues if changing what we sort by
    if (currentSort !== null) {
        $(`#products_list_${currentSort}_header`).text(`${capitalise(currentSort)}`);
    }
    // swap to descending sort if sorting by the same attribute
    if(attribute === currentSort && currentOrder !== "desc") {
        loadProductsList(`${path}?sortBy=${attribute}&orderBy=desc`);
        $(`#products_list_${attribute}_header`).text(`${capitalise(attribute)} ▼`);
        currentOrder = "desc";
    } else {
        loadProductsList(`${path}?sortBy=${attribute}`);
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