$(document).ready(function() {
  $(document).on('keyup change', '.cart-quantity', function() {
    var _href = $(this).parent('span').next().find('a').attr('href');
    var quantity = $(this).val();
    if($(this).val() !== '') {
      $(this).parent('span').next().find('a').attr('href', _href.replace(/qty=[^&]+/, 'qty=' + quantity));
    } else {
      $(this).parent('span').next().find('a').attr('href', _href.replace(/qty=[^&]+/, 'qty=1'));
    }
  })

  $(document).on('blur', '.cart-quantity', function() {
    if($(this).val() === '') {
      $(this).val('1');
    }
  });

  $(document).on('blur', '.update-cart-book', function() {
    var old_qty = $(this).attr('data-old-value');
    if($(this).val() === '') {
      $(this).val(old_qty);
    }
  });

  $(document).on('keyup change', '.update-cart-book', function() {
    let _href1 = $(this).parent('td').next().next().find('a:first').attr('href');
    var old_qty = $(this).attr('data-old-value');
    var new_qty = $(this).val();
    if($(this).val() !== '') {
      $(this).parent('td').next().next().find('a:first').attr('href', _href1.replace(/qty=[^&]+/, 'qty=' + new_qty));
    } else {
      $(this).parent('td').next().next().find('a:first').attr('href', _href1.replace(/qty=[^&]+/, 'qty='+old_qty));
    }
  })
  // $(document).on('blur', '.update-cart-book', function() {
  //   var qty = $(this).val();
  //   var id = $(this).attr('data-book-id');
  //   var old_qty = $(this).attr('data-old-value');
  //   if(old_qty != qty)
  //   {
  //     $.ajax({
  //       url: 'carts/' + id,
  //       type: "put",
  //       data: {
  //         id: id
  //       }
  //     })
  //   }
  // })
})
