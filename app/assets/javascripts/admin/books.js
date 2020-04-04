$(document).on('turbolinks:load', function () {
  $('#btn-updload-avatar').on('click', function () {
    $('.form-user .panel-heading input[type="file"]').trigger('click');
  });

  $('body').on('change', 'input#js-image-input', function(event){
    if(this.files[0].size/1024/1024 > 1) {
      $('#img-size-error').text(I18n.t('img_size_error', {size: 1}));
    } else {
      var input = this;
      var target = $(event.currentTarget);
      var file = target[0].files[0];
      var reader = new FileReader();
      reader.onload = function(e){
        var img = new Image();
        img.src = e.target.result;
        $('#js-image-tag').attr('src', img.src);
      };
      reader.readAsDataURL(file);
    }
  });
  $('.select-select2').select2();
});

$(document).ready(function() {
  $(document).on('click', '.delete-book-button', function() {
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
          url: '/admin/books/' + id,
          method: 'DELETE',
          data: {
            id: id
          }
        });
      }
    })

  });
});
