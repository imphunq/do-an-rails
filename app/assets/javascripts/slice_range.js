//-----JS for Price Range slider-----

$(document).on("turbolinks:load", function(){
    function formatNumber(nStr, decSeperate, groupSeperate) {
    nStr += '';
    x = nStr.split(decSeperate);
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + groupSeperate + '$2');
    }
    return x1 + x2;
  }
  $("#price").text(formatNumber(700000, '.', ','));

  $( "#slider-range" ).slider({
    range: true,
    min: 30000,
    max: 1000000,
    values: [ 30000, 1000000 ],
    slide: function( event, ui ) {
      var val1 = formatNumber(ui.values[0], '.', ',')
      var val2 = formatNumber(ui.values[1], '.', ',')
      $( "#amount" ).val(val1 + " - " + val2 );
    }
  });

  var slider1 = formatNumber($('#slider-range').slider("values")[0], '.', ',');
  var slider2 = formatNumber($('#slider-range').slider("values")[1], '.', ',');

  $( "#amount" ).val(slider1 + " - " + slider2);
})
