$(document).on('turbolinks:load', function() {
  $('.wysiwyg-editor').froalaEditor({
    key: 'QA4A3A3A15hC7D6E6C5D2E3B2C6A6D6ctigoehvogD-11ogF4I-7k==',
    heightMin: 200,
    paragraphFormat: {
      N: 'Normal',
      H3: 'Underrubrik',
      H4: 'Underunderrubrik'
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
});
