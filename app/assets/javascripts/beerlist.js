var BEERS = {};

BEERS.show = function(){
    var beer_list = [];

    $.each(BEERS.list, function (index, beer) {
        beer_list.push('<li>' + beer['name'] + '</li>')
    });

    $("#beers").html('<ul>'+ beer_list.join('') + '</ul>');
};

BEERS.reverse = function(){
    BEERS.list.reverse();
};

$(document).ready(function () {
    $("#reverse").click(function (e) {
        BEERS.reverse();
        BEERS.show();
        e.preventDefault();
    });

    $.getJSON('beers.json', function (beers) {
        BEERS.list = beers;
        BEERS.show();
    });
});
