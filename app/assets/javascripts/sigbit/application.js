//= require rails-ujs
//= require jquery
//= require turbolinks
//= require sigbit/rrt
//= require cocoon
//= require froala_editor.min.js
//= require plugins/table.min.js
//= require plugins/link.min.js
//= require plugins/word_paste.min
//= require plugins/paragraph_format.min
//= require plugins/lists.min
//= require plugins/quote.min.js
//= require moment
//= require moment/sv.js
//= require tempusdominus-bootstrap-4.js
//= require sigbit/html5sortable
//= require jquery.ui.widget
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require sigbit/attachinary_template

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

  $('#accordion')
    .find('button')
    .on('click', function(event) {
      event.preventDefault();
    });

  $('.wysiwyg-editor').froalaEditor({
    key: 'QA4A3A3A15hC7D6E6C5D2E3B2C6A6D6ctigoehvogD-11ogF4I-7k==',
    heightMin: 200,
    paragraphFormat: {
      N: 'Normal',
      H3: 'Rubrik 1',
      H4: 'Rubrik 2',
      H5: 'Rubrik 3'
    },
    tableStyles: {
      'table table-striped table-bordered': 'Normal'
    },
    tableEditButtons: [
      'tableHeader',
      'tableRemove',
      '|',
      'tableRows',
      'tableColumns',
      '-',
      'tableStyle',
      'tableCells',
      'tableCellHorizontalAlign'
    ],

    toolbarButtons: [
      'undo',
      'redo',
      '|',
      'bold',
      'italic',
      'underline',
      'strikeThrough',
      'paragraphFormat',
      'clearFormatting',
      'insertTable',
      'insertLink',
      'formatOL',
      'formatUL',
      'quote'
    ],

    linkEditButtons: ['linkOpen', 'linkStyle', 'linkEdit', 'linkRemove'],

    linkAttributes: {
      class: 'Class'
    }
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
