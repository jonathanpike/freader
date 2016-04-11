var ready = function() {
    "use strict";

    var y_pos = $('#navbar').offset().top;
    var height = $('#navbar').height();

    $(document).scroll(function() {
        var scrollTop = $(this).scrollTop();

        if (scrollTop > (y_pos + height) + 25) {
            $('#navbar').addClass("navbar-fixed").animate({
                top: 0
            });
        } else if (scrollTop <= y_pos) {
            $('#navbar').removeClass("navbar-fixed").clearQueue().animate({
                top: "-48px"
            }, 0);
        }
    });

};

$(document).ready(ready);
$(document).on('page:load', ready);