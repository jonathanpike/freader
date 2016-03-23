var ready = function() {
  $('a[data-popup]').on('click', function(e) {
    e.preventDefault();
    window.open($(this).attr('href'), "_blank", "width=600,height=600");
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);

