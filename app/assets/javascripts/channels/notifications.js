App.notifications = App.cable.subscriptions.create({
  channel: 'NotificationsChannel'
},
{
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    // $('.noti-counter').html(data.counter);
    $('#notificationList').prepend("" + data.notification);
    if(window.location.pathname.includes("admin"))
    {
      toastr.success("Ban vua co thong bao moi");
    }
    return this.update_counter(data.counter);
  },
  update_counter: function(counter) {
    var $counter, val;
    $counter = $('.noti-counter');
    val = parseInt($counter.text());
    val++;
    return $counter.css({
      opacity: 1
    }).text(val);
  }
});
