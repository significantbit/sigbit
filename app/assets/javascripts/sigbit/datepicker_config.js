$(document).on('turbolinks:load', function() {
  $('.datetime-picker').datetimepicker({
    locale: 'sv',
    keepOpen: true
  });
  $('.date-picker').datetimepicker({
    locale: 'sv',
    format: 'L',
    keepOpen: true
  });
  $('.time-picker').datetimepicker({
    locale: 'sv',
    format: 'LT',
    keepOpen: true
  });
});
