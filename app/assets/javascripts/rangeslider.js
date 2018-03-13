$(function() {

  // Initiate Slider
  $("#radius-slider-range").slider({
    range: true,
    min: 0,
    max: 30,
    step: 0.1,
    values: [0, 30]
  });

  // Move the range wrapper into the generated divs
  $('#radius-ui-slider-range').append($('.radius-range-wrapper-left'));
  $('#radius-ui-slider-range').append($('.radius-range-wrapper-right'));
  // Apply initial values to the range container
  $('.radius-range-left').html('<span class="radius-range-value" name="min" id="min" action="/places/show" method="get" type="range">' + $('#radius-slider-range').slider("values", 0).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' km</span>');
  $('.radius-range-right').html('<span class="radius-range-value" name="max" id="max" action="/places/show" method="get" type="range">' + $('#radius-slider-range').slider("values", 1).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' km</span>');
  // $('.range-wrapper-right').html('<input type="hidden" name="min_price" value='$('#slider-range').slider("values", 0).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")'></input>');
  // $('.radius-range-left-hidden').html('<input type="hidden" naction="/places/show" method="get" name="min_price" value=' + $('#radius-slider-range').slider("values", 0).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + '></input>');
  // $('.radius-range-right-hidden').html('<input type="hidden" action="/places/show" method="get" name="max_price" value=' + $('#radius-slider-range').slider("values", 1).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + '></input>');

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
    rangeWidth = $('.radius-ui-slider-range').css('width');

  $('.gear-one').css('transform', 'rotate(' + gearOneAngle + 'deg)');
  $('.gear-two').css('transform', 'rotate(' + gearTwoAngle + 'deg)');

  $('#radius-slider-range').slider({
    slide: function(event, ui) {

      // Update the range container values upon sliding

      $('.radius-range-left').html('<span class="radius-range-value" name="min_price" id="min_price" action="/places/show" method="get" type="range">' + ui.values[0].toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' km</span>');
      $('.radius-range-right').html('<span class="radius-range-value" name="max_price" id="max_price" action="/places/show" method="get" type="range">' + ui.values[1].toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + ' km</span>');
      // $('.radius-range-left-hidden').html('<input type="hidden" action="/places/show" method="get" name="min_price" value=' + $('#radius-slider-range').slider("values", 0).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + '></input>');
      // $('.radius-range-right-hidden').html('<input type="hidden" action="/places/show" method="get" name="max_price" value=' + $('#radius-slider-range').slider("values", 1).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") + '></input>');
      // // Get old value
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
  $('.radius-range, .radius-range-alert').on('mousedown', function(event) {
    event.stopPropagation();
  });

});

$(".radius-ui-slider-handle").draggable();
