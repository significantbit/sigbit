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
//= require froala_editor.min.js
//= require plugins/table.min.js
//= require plugins/link.min.js
$(document).on('turbolinks:load', function() {
  // $R('.wysiwyg-editor', {
  //   lang: 'sv',
  //   formatting: ['p', 'h2', 'h3', 'h4'],
  //   plugins: ['table', 'clips'],
  //   clips: [
  //     ['Responsiv tabell', '<div class="table-responsive"><table class="table table-sm"><tbody><tr><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td></tr></tbody></table></div>']
  // ],
  //   callbacks: {
  //     inserted: function(nodes)
  //     {
  //       console.log(nodes[0].dataset);
  //       if(nodes[0].dataset.redactorType == "table") {
  //         nodes[0].lastChild.classList.remove("table");
  //         nodes[0].lastChild.classList.add("table");
  //       }

  //     }
  // }
  // });

  new FroalaEditor('.wysiwyg-editor', {
    key: 'BWC6D-16A3C1D2F1D1A5vb2EAJLQCVLUVBd1NXNRSSATEXC-8C2H2C4B3B6C2E2C4A1D1==',
    attribution: false,
    toolbarButtons: ['bold', 'italic', 'underline', 'insertTable', 'insertLink', 'inlineClass', 'inlineStyle', 'clearFormatting'],
    tableMultipleStyles: true,
    events: {
      'table.inserted': function (table) {
        table.classList.remove('table', 'table-sm');
        table.classList.add('table', 'table-sm');
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
