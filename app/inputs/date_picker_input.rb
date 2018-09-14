
class DatePickerInput < SimpleForm::Inputs::StringInput

  def input_html_classes
    super.push("date-picker")
  end

  def input_html_options
    super.merge({ data: { toggle: 'datetimepicker', target: "##{the_id}" } })
  end

  def the_id
    "#{object_name} #{attribute_name}".gsub(/\[|\]|\s/, "_").gsub("__", "_")
  end

end
