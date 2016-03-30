var ready = function() {
  $('body').on('click', '.select_all', function(e) {
    var cbxs = $('input[type="checkbox"]');
    cbxs.prop("checked", !cbxs.prop("checked"));
  });

  $('#reload').on('click', function(e) {
    location.reload();
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);