$(document).ready(function() {
  $(document).on('change', '.select-month-stats', function() {
    var month = $( ".select-month-stats option:selected" ).val();
    $.ajax({
      url: '/admin/statistic_orders',
      method: "get",
      data: {
        month: month
      },
      success: function() {
        history.pushState(null, null, '/admin/statistic_orders?month='+month);
      }
    });
  });
})
