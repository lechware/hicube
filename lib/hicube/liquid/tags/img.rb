module Canteen
  module Liquid
    module Tags
      class ImgTag < ::Liquid::Tag

        def initialize(tag_name, name, tokens)
          super
          # FIXE: 3. Fix search using correct model
          @img = Hicube::Document.images.find_by(name: name)
        rescue
        end

        def render(context)
          # FIXE: 4. Fix search using correct model
          @img.nil? ? "image_not_found" : @img.image_url
        end
      end

      ::Liquid::Template.register_tag('img_tag', ImgTag)

    end
  end
end 