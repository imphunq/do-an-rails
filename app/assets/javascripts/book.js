$(document).ready(function() {
  $(document).on('click', '.check-visited', function() {
    var book_id = $(this).attr('data-book-id');

    $.ajax({
      url: '/books/' + book_id + '/update_visited',
      method: "put",
      data: {
        book_id: book_id
      }
    });
  })
})
