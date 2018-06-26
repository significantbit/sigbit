class ImageWidgetInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options = {})
    template.content_tag :div, class: 'outer d-flex align-items-center' do
      template.concat(
        template.content_tag(:div, class: 'image-preview mr-4', id: resource_signed_id) do
          if resource_attached?
            template.concat(
              template.image_tag(
                template.main_app.url_for(
                  resource.variant(resize: "100x100>")
                )
            ))
            template.concat(
              template.link_to(template.attachment_path(resource_signed_id), method: :delete, remote: true) do
              template.icon('fas', 'trash delete')
            end)

          else
            template.image_tag(
              "http://placehold.it/400x400?text=Ingen bild", width: 100, height: 100
            )
          end
        end
      )

        template.concat(
          template.content_tag(:div, id: "#{resource_signed_id}-input", class: "input #{'d-none' if resource.attached?}") do
            @builder.file_field attribute_name
          end
        )

    end
  end

  private

  def resource_attached?
    resource.attached?
  end

  def resource_signed_id
    if resource.attached?
      resource.signed_id
    else
      "no-#{attribute_name}"
    end
  end

  def resource
    @builder.object.send(attribute_name)
  end


end
