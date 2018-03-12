$(function() {

  // Initiate Slider
  $("#slider-range").slider({
    range: true,
    min: 10,
    max: 180,
    step: 1,
    values: [0, 180]
  });

  // Move the range wrapper into the generated divs
  $('.ui-slider-range').append($('.range-wrapper-left'));
  $('.ui-slider-range').append($('.range-wrapper-right'));
  // Apply initial values to the range container
  $('.range-left').html('<span class="range-value" name="min" id="min" action="/places/show" method="get" type="range">' + $('#slider-range').slider("values", 0).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' €</span>');
  $('.range-right').html('<span class="range-value" name="max" id="max" action="/places/show" method="get" type="range">' + $('#slider-range').slider("values", 1).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' €</span>');
  // $('.range-wrapper-right').html('<input type="hidden" name="min_price" value='$('#slider-range').slider("values", 0).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")'></input>');
  $('.range-left-hidden').html('<input type="hidden" naction="/places/show" method="get" ame="min_price" value=' + $('#slider-range').slider("values", 0).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + '></input>');
  $('.range-right-hidden').html('<input type="hidden" action="/places/show" method="get" name="max_price" value=' + $('#slider-range').slider("values", 1).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + '></input>');

  // Hide the gears when the mouse is released
  // Done on document just incase the user hovers off of the handle
  $(document).on('mouseup', function() {
    if ($('.gear-large').hasClass('active')) {
      $('.gear-large').removeClass('active');
    }
  });

  // Rotate the gears
  var gearOneAngle = 0,
    gearTwoAngle = 0,
    rangeWidth = $('.ui-slider-range').css('width');

  $('.gear-one').css('transform', 'rotate(' + gearOneAngle + 'deg)');
  $('.gear-two').css('transform', 'rotate(' + gearTwoAngle + 'deg)');

  $('#slider-range').slider({
    slide: function(event, ui) {

      // Update the range container values upon sliding

      $('.range-left').html('<span class="range-value" name="min_price" id="min_price" action="/places/show" method="get" type="range">' + ui.values[0].toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' €</span>');
      $('.range-right').html('<span class="range-value" name="max_price" id="max_price" action="/places/show" method="get" type="range">' + ui.values[1].toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' €</span>');
      $('.range-left-hidden').html('<input type="hidden" action="/places/show" method="get" name="min_price" value=' + $('#slider-range').slider("values", 0).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + '></input>');
      $('.range-right-hidden').html('<input type="hidden" action="/places/show" method="get" name="max_price" value=' + $('#slider-range').slider("values", 1).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + '></input>');
      // Get old value
      var previousVal = parseInt($(this).data('value'));

      // Save new value
      $(this).data({
        'value': parseInt(ui.value)
      });

      // Figure out which handle is being used
      if (ui.values[0] == ui.value) {

        // Left handle
        if (previousVal > parseInt(ui.value)) {
          // value decreased
          gearOneAngle -= 7;
          $('.gear-one').css('transform', 'rotate(' + gearOneAngle + 'deg)');
        } else {
          // value increased
          gearOneAngle += 7;
          $('.gear-one').css('transform', 'rotate(' + gearOneAngle + 'deg)');
        }

      } else {

        // Right handle
        if (previousVal > parseInt(ui.value)) {
          // value decreased
          gearOneAngle -= 7;
          $('.gear-two').css('transform', 'rotate(' + gearOneAngle + 'deg)');
        } else {
          // value increased
          gearOneAngle += 7;
          $('.gear-two').css('transform', 'rotate(' + gearOneAngle + 'deg)');
        }

      }

      if (ui.values[1] === 110000) {
        if (!$('.range-alert').hasClass('active')) {
          $('.range-alert').addClass('active');
        }
      } else {
        if ($('.range-alert').hasClass('active')) {
          $('.range-alert').removeClass('active');
        }
      }
    }
  });

  // Prevent the range container from moving the slider
  $('.range, .range-alert').on('mousedown', function(event) {
    event.stopPropagation();
  });

});
