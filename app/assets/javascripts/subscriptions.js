var visible = $('.new_subscription_box').hasClass('hide');

var ready = function() {
  
  $('.sidebar').on('click', '.new_subscription_button', function(e) { 
    e.preventDefault();
    
    new Tether({
      element: '.new_subscription_box',
      target: '.new_subscription_button',
      attachment: 'middle left'
    });
    
    if (visible) {
    	$('.new_subscription_box').fadeOut('fast',function(){
        $('.new_subscription_box').addClass('hide')
             .fadeIn(0); });
     } else {
      	$('.new_subscription_box').fadeOut(0,function(){
        $('.new_subscription_box').removeClass('hide')
             .fadeIn('fast'); });
     }
    visible = ! visible;
  });

  $('body').on('click', '.select_all', function(e) {
    var cbxs = $('input[type="checkbox"]');
    cbxs.prop("checked", !cbxs.prop("checked"));
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);