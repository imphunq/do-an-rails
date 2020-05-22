$(document).ready(() => {
  var getUrlParameter = function getUrlParameter(sParam) {
  var sPageURL = window.location.search.substring(1),
      sURLVariables = sPageURL.split('&'),
      sParameterName,
      i;

  for (i = 0; i < sURLVariables.length; i++) {
      sParameterName = sURLVariables[i].split('=');

      if (sParameterName[0] === sParam) {
          return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
      }
  }
  };
  var params_criteria = getUrlParameter('criteria');
  if(params_criteria) {
    $('.nav-tabs li').removeClass('active');
    $('.'+params_criteria).parent('li').addClass('active')
  }

  $('.nav-tabs li a').on('click', function() {
    $('.nav-tabs li').removeClass('active');
    $(this).parent('li').addClass('active');
    history.pushState(null, null, $(this).attr("href"));
  })

  $(window).scroll(function() {
    sessionStorage.scrollTop = $(this).scrollTop();
  });

  $(document).ready(function() {
    if (sessionStorage.scrollTop != "undefined") {
      $(window).scrollTop(sessionStorage.scrollTop);
    }
  });

  var type_view = getUrlParameter('view');
  if(type_view == "list") {
    $('.shopping-page #home').removeClass('in active');
    $('.shopping-page #menu1').addClass('in active');
    $('.list').parent('li').addClass('active');
    $('.grid').parent('li').removeClass('active');
  }

  // $(document).on('click', '.option-user')
});

$(document).on("turbolinks:load", function(){
  $('.type-view').on('click', function() {
    $('.type-view').parent('li').removeClass('active');
    $(this).parent('li').addClass('active');
    history.pushState(null, null, $(this).attr("href"));
  });

  var type_view = getUrlParameter('view');
    if(type_view == "list") {
      $('.shopping-page #home').removeClass('in active');
      $('.shopping-page #menu1').addClass('in active');
      $('.list').parent('li').addClass('active');
      $('.grid').parent('li').removeClass('active');
    }
});
