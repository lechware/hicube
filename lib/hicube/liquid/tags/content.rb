module Hicube
  module Liquid
    module Tags
      class ContentTag < ::Liquid::Tag

        def initialize(tag_name, variables, tokens)
          @variables = variables
          super
        end

        def render(context)
          @page = Hicube::Page.find(@variables.split(" ").first)
          @content = @page.content.find(@variables.split(" ").last)
      
          "<div class=\"editable\" data-type=\"wysihtml5\" data-name=\"content[body]\" data-url=\"/hicube/pages/#{@page.slug}/contents/#{@content.slug}\">#{@content.body}</div>\n"
        rescue
          return "<div class=\"alert alert-danger\" role=\"alert\">Oh Snap! Content not found.</div>"
        end
      end

      ::Liquid::Template.register_tag('content_tag', ContentTag)

    end
  end
end 