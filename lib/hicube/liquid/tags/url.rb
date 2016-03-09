module Hicube
  module Liquid
    module Tags
      class UrlTag < ::Liquid::Tag

        def initialize(tag_name, name, tokens)
          super
          @doc_name = name
        rescue
        end

        def render(context)
          @doc = Hicube::Document.find_by(name: @doc_name, account: context['account'])
          @doc.nil? ? "document_not_found" : @doc.file_url
        rescue
          "document_not_found for name #{name} and #{context['account']}"
        end
      end

      ::Liquid::Template.register_tag('url_tag', UrlTag)

    end
  end
end 