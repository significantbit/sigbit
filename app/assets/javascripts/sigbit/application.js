//= require rails-ujs
//= require jquery
//= require turbolinks
//= require sigbit/rrt
//= require cocoon
//= require froala_editor.min.js
//= require plugins/align.min.js
//= require plugins/code_beautifier.min.js
//= require plugins/code_view.min.js
//= require plugins/entities.min.js
//= require plugins/file.min.js
//= require plugins/font_family.min.js
//= require plugins/font_size.min.js
//= require plugins/help.min.js
//= require plugins/image.min.js
//= require plugins/image_manager.min.js
//= require plugins/inline_style.min.js
//= require plugins/line_breaker.min.js
//= require plugins/link.min.js
//= require plugins/lists.min.js
//= require plugins/paragraph_format.min.js
//= require plugins/paragraph_style.min.js
//= require plugins/quote.min.js
//= require plugins/table.min.js
//= require plugins/special_characters.min.js
//= require plugins/url.min.js
//= require plugins/video.min.js
//= require plugins/word_paste.min

//= require moment
//= require moment/sv.js
//= require tempusdominus-bootstrap-4.js
//= require sigbit/html5sortable
//= require sigbit/jquery.ui.widget
//= require sigbit/jquery.iframe-transport
//= require sigbit/jquery.fileupload
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require sigbit/attachinary_template
//= require sigbit/content_type
//= require sigbit/config/froala_config
//= require sigbit/config/datepicker_config

$(document).on('turbolinks:load', function() {
  $('.attachinary-input').attachinary();
  var a = sortable('.sortable-list', {
    items: '.list-group-item',
    handle: '.handle'
  }).forEach(function(e, i) {
    e.addEventListener('sortupdate', function(e) {
      const data = [];
      e.detail.origin.items.forEach(function(e, i) {
        data.push({ id: $(e).data('id'), position: i + 1 });
      });

      var url = $(e.target).data('sort-url');
      $.ajax({
        url: url,
        type: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({ order: data })
      }).then(function() {
        if (
          window.NodesApplication !== undefined &&
          window.NodesApplication !== null
        ) {
          NodesApplication.reload();
        }
      });
    });
  });



  $('#accordion')
    .find('button')
    .on('click', function(event) {
      event.preventDefault();
    });



  var url = document.location.toString();
  if (url.match('#')) {
    $('.nav-tabs a[href="#' + url.split('#')[1] + '"]').tab('show');
  }

  // Change hash for page-reload
  $('.nav-tabs a').on('shown.bs.tab', function(e) {
    history.replaceState(null, null, e.target.hash);
  });
});
