class MobilityFormBuilder < SimpleForm::FormBuilder
  def input(attribute_name, options = {}, &block)
    if @object.translated_attribute_names.include?(attribute_name.to_s)
      super(attribute_name,
        options.merge(
          input_html: {
            placeholder: @object.send(attribute_name),
            value: @object.send(
              attribute_name,
              fallback: false,
              default: nil
            )
          }
        )
      )
    else
      super(attribute_name, options)
    end
  end
end
