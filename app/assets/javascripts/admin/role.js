$(document).ready(function() {
  $(document).on('click', '.delete-role-button', function() {
    var id = $(this).attr('data-id');
    var name = $(this).attr('data-name');
    Swal.fire({
      title: I18n.t('admin.categories.destroy.sure'),
      text: "You won't be able to revert this!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
      if(result.value){
        $.ajax({
          url: '/admin/roles/' + id,
          method: 'DELETE',
          data: {
            id: id
          }
        });
      }
    })

  });
})
