class WysiwygInput < SimpleForm::Inputs::TextInput
  def input_html_classes
    super.push("wysiwyg-editor")
  end
end
