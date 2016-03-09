$(document).on('ready page:load', function() {
  $('.new_subscription_button').on('click', function(e) { 
    e.preventDefault()
    if ($('.new_subscription_box').hasClass('visible')) {
      $('.new_subscription_box').removeClass('visible');
      $('.new_subscription_box').addClass('invisible');
    } else {
      $('.new_subscription_box').removeClass('invisible');
      $('.new_subscription_box').addClass('visible');
    }
  });
});
