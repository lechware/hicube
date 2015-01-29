module Hicube
  module Liquid
    module Tags
      class FileTag < ::Liquid::Tag

        def initialize(tag_name, name, tokens)
          super
          @file = Hicube::Document.files.find_by(name: name)
        rescue
        end

        def render(context)
          @file.nil? ? "file_not_found" : @file.file_url
        end
      end

      ::Liquid::Template.register_tag('file_tag', FileTag)

    end
  end
end 