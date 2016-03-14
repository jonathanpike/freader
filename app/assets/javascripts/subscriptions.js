var ready = function() {
  $('.new_subscription_button').on('click', function(e) { 
    e.preventDefault();
    if ($('.new_subscription_box').hasClass('visible')) {
      $('.new_subscription_box').removeClass('visible');
      $('.new_subscription_box').addClass('invisible');
    } else {
      $('.new_subscription_box').removeClass('invisible');
      $('.new_subscription_box').addClass('visible');
    }
  });
  
  $('body').on('click', '.select_all', function(e) {
    var cbxs = $('input[type="checkbox"]');
    cbxs.prop("checked", !cbxs.prop("checked"));
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);