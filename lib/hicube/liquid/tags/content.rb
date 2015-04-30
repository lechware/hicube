module Hicube
  module Liquid
    module Tags
      class ContentTag < ::Liquid::Tag

        def initialize(tag_name, variables, tokens)
          @variables = variables
          super
        end

        def render(context)
          return "<div class=\"alert alert-danger\" role=\"alert\">Supply page and content names in content_tag</div>" if @variables.split(" ").count < 2

          @page = Hicube::Page.unscoped.find(@variables.split(" ").first) 
          @content = @page.content.find(@variables.split(" ").last)
      
          "<div class=\"editable\" data-type=\"wysihtml5\" data-name=\"content[body]\" data-url=\"/hicube/pages/#{@page.slug}/contents/#{@content.slug}\">#{@content.body}</div>\n"
        rescue
          if @page.nil? # page is not spelt correct
            return "<div class=\"alert alert-danger\" role=\"alert\">Oh Snap! Page not found.</div>"
          else # return content with alert div, so that new content can be created
            return "<div class=\"editable\" data-type=\"wysihtml5\" data-name=\"content[body]\" data-url=\"/hicube/pages/#{@page.slug}/contents/#{@variables.split(" ").last}\"><div class=\"alert alert-warning\" role=\"alert\">Content not found. Create new content...</div></div>\n"      
          end
        end
      end

      ::Liquid::Template.register_tag('content_tag', ContentTag)

    end
  end
end 
