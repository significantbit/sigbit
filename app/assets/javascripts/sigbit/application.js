// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
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
//= require moment
//= require moment/sv.js
//= require tempusdominus-bootstrap-4.js
//= require sigbit/html5sortable

$(document).on('turbolinks:load', function () {

  var a = sortable('.sortable-list', {
    items: '.list-group-item',
    handle: '.handle',
  }).forEach(function(e,i) {
    e.addEventListener('sortupdate', function(e) {

      e.detail.origin.items.forEach(function(e, i) {
        console.log(e);
        $(e).data('position', i);

      });

      var url = $(e.target).data('sort-url');


      /*
      This event is triggered when the user stopped sorting and the DOM position has changed.

      e.detail.item - {HTMLElement} dragged element

      Origin Container Data
      e.detail.origin.index - {Integer} Index of the element within Sortable Items Only
      e.detail.origin.elementIndex - {Integer} Index of the element in all elements in the Sortable Container
      e.detail.origin.container - {HTMLElement} Sortable Container that element was moved out of (or copied from)
      e.detail.origin.itemsBeforeUpdate - {Array} Sortable Items before the move
      e.detail.origin.items - {Array} Sortable Items after the move

      Destination Container Data
      e.detail.destination.index - {Integer} Index of the element within Sortable Items Only
      e.detail.destination.elementIndex - {Integer} Index of the element in all elements in the Sortable Container
      e.detail.destination.container - {HTMLElement} Sortable Container that element was moved out of (or copied from)
      e.detail.destination.itemsBeforeUpdate - {Array} Sortable Items before the move
      e.detail.destination.items - {Array} Sortable Items after the move
      */
  });
  });

  console.log(a);

  $('.datetime-picker').datetimepicker({
    locale: 'sv',
    keepOpen: true,
  });
  $('.date-picker').datetimepicker({
    locale: 'sv',
    format: 'L',
    keepOpen: true,
  });
  $('.time-picker').datetimepicker({
    locale: 'sv',
    format: 'LT',
    keepOpen: true,
  });

  $('#accordion').find('button').on('click', function(event) {
    event.preventDefault();
  });

  $('.wysiwyg-editor').froalaEditor({
    key: 'QA4A3A3A15hC7D6E6C5D2E3B2C6A6D6ctigoehvogD-11ogF4I-7k==',
    heightMin: 200,
    paragraphFormat: {
      N: 'Normal',
      H3: 'Underrubrik',
      H4: 'Underunderrubrik',
    },
    tableStyles: {
      'table table-striped table-bordered': 'Normal',
    },
    tableEditButtons: [
      'tableHeader', 'tableRemove', '|', 'tableRows', 'tableColumns', '-',
      'tableStyle', 'tableCells', 'tableCellHorizontalAlign'],

    toolbarButtons: ['undo', 'redo' , '|','bold', 'italic', 'underline', 'strikeThrough',
      'paragraphFormat', 'clearFormatting', 'insertTable', 'insertLink', 'formatOL', 'formatUL'],

    linkEditButtons: ['linkOpen', 'linkStyle', 'linkEdit', 'linkRemove'],

    linkAttributes: {
  class: 'Class'
},
  });

  var url = document.location.toString();
  if (url.match('#')) {
      $('.nav-tabs a[href="#' + url.split('#')[1] + '"]').tab('show');
  }

  // Change hash for page-reload
  $('.nav-tabs a').on('shown.bs.tab', function (e) {
    history.replaceState(null, null, e.target.hash);
  })
});
