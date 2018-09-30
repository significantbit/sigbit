class ContentTypeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)
  argument :name, type: :string
  argument :attributes, type: :array, default: [], banner: "field:field_type field:field_type"

  def create_model
    generate "model ContentType::#{class_name} #{fields_as_string}"
    inject_into_file "#{Rails.root}/app/models/content_type/#{name.downcase}.rb", "require \"mobility\"\n", before: "class ContentType::#{class_name} < ApplicationRecord\n"
    inject_into_file "#{Rails.root}/app/models/content_type/#{name.downcase}.rb", "  extend Mobility\n  include Sigbit::Contentable\n", after: "class ContentType::#{class_name} < ApplicationRecord\n"
    inject_into_file "#{Rails.root}/app/models/content_type/#{name.downcase}.rb", "\n  translates :title, fallbacks: { en: :sv }, locale_accessors: true\n", after: "include Sigbit::Contentable\n"
    inject_into_file Dir.glob("db/migrate/*create_content_type_*").sort.last, "      t.jsonb :translations, default: {}\n", before: "      t.timestamps\n"
  end

  def create_form
    template "form.html.erb", File.join("app/views/sigbit/content_type", "_#{name.downcase}.html.erb")
  end

  def create_frontend
    template "frontend.html.erb", File.join("app/views/content_type", "_#{name.downcase}.html.erb")
  end

  #def create_translations
  #  data = YAML::load_file('config/locales/en.yml')
  #  data['en']['activerecord']['models']["content_type/#{name.downcase}"] = "#{name.downcase} (generated translation)"
  #  data['en']['activerecord']['attributes']["content_type/#{name.downcase}"] = {}
  #  File.open('config/locales/en.yml', 'w') { |f| f.write data.to_yaml }
  #end

  private
    def class_name
      name.classify
    end

    def fields_as_string
      fields = ""
      attributes.each do |col|
        fields += "#{col.name.to_s}:#{col.type.to_s} "
      end
      fields
    end
end
