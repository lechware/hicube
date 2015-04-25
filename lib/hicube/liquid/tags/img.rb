module Hicube
  module Liquid
    module Tags
      class ImgTag < ::Liquid::Tag

        def initialize(tag_name, name, tokens)
          @img = Hicube::Document.find_by(name: name)
          super
        rescue
        end

        def render(context)
          @img.nil? ? "img src=\"image_not_found.png\" alt=\"image_not_found\"" : "img src=\"#{@img.file_url}\""
        end
      end

      ::Liquid::Template.register_tag('img_tag', ImgTag)

    end
  end
end 