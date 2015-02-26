module Hicube
  module Liquid
    module Tags
      class DocTag < ::Liquid::Tag

        def initialize(tag_name, name, tokens)
          super
          @doc = Hicube::Document.files.find_by(name: name)
        rescue
        end

        def render(context)
          @doc.nil? ? "document_not_found" : @doc.file_url
        end
      end

      ::Liquid::Template.register_tag('doc_tag', DocTag)

    end
  end
end 