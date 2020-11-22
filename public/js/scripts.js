loadSingleProduct = function(type) {
    $.get(`product/${type}`, function( product_data ) {
        console.log(`#${type}`);
        $(`#${type}_product`).prepend(`<img src="${product_data.image}">`);
        $(`#${type}_product .name`).text(product_data.name);
        $(`#${type}_product .style`).text(product_data.style);
        $(`#${type}_product .price`).text(product_data.price);
    });
};

$( document ).ready(function(){
    loadSingleProduct("cheapest");
    loadSingleProduct("most_expensive");
});