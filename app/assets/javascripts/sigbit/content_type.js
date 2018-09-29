$(document).on('turbolinks:load', function() {
  $('#new_form_parent_id_select').on('change', function(e) {
    var parent_id = $(this).val();
    window.location = "/admin/nodes/new?parent_id=" + parent_id
  })
});
