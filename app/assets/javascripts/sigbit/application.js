//= require rails-ujs
//= require jquery
//= require turbolinks
//= require sigbit/rrt
//= require cocoon

//= require moment
//= require moment/sv.js
//= require tempusdominus-bootstrap-4.js
//= require sigbit/html5sortable
//= require sigbit/jquery.ui.widget
//= require sigbit/jquery.iframe-transport
//= require sigbit/jquery.fileupload
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require sigbit/webpacker/pack
//= require sigbit/attachinary_template
//= require sigbit/content_type
//= require sigbit/config/datepicker_config
//= require redactor/redactor
//= require redactor/_langs/sv
//= require redactor/_plugins/table/table

$(document).on('turbolinks:load', function() {
  $R('.wysiwyg-editor', {
    lang: 'sv',
    plugins: ['table'],
    callbacks: {
      inserted: function(nodes)
      {
        if(nodes[0].dataset.redactorType == "table") {
          nodes[0].lastChild.classList.remove("table");
          nodes[0].lastChild.classList.add("table");
        }

      }
  }
  });

  $('#create-new-block-btn').click(function(e) {
    e.preventDefault();
    a = alert('Har du sparat innan? Om du lägger till en ny modul försvinner saker du inte sparat på sidan.')
  });
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
