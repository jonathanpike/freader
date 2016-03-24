var ready = function() {
  $('body').on('click', '.select_all', function(e) {
    var cbxs = $('input[type="checkbox"]');
    cbxs.prop("checked", !cbxs.prop("checked"));
  });
  
  $.lockfixed(".my_subscriptions", {offset: {top: 10, bottom: 100}});
};

$(document).ready(ready);
$(document).on('page:load', ready);