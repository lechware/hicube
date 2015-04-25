module Hicube
  module Liquid
    module Tags
      class UrlTag < ::Liquid::Tag

        def initialize(tag_name, name, tokens)
          super
          @doc = Hicube::Document.find_by(name: name)
        rescue
        end

        def render(context)
          @doc.nil? ? "document_not_found" : @doc.file_url
        end
      end

      ::Liquid::Template.register_tag('url_tag', UrlTag)

    end
  end
end 