module Hicube
  module Liquid
    module Tags
      class ImgTag < ::Liquid::Tag

        def initialize(tag_name, name, tokens)
          @img_name = name
          super
        rescue
        end

        def render(context)
          @img = Hicube::Document.find_by(name: @img_name, account: context['account'])
          @img.nil? ? "img src=\"image_not_found.png\" alt=\"image_not_found\"" : "img src=\"#{@img.file_url}\""
        rescue
          "img src=\"image_not_found.png\" alt=\"image_not_found for name #{name} and #{context['account']}\""
        end
      end

      ::Liquid::Template.register_tag('img_tag', ImgTag)

    end
  end
end 