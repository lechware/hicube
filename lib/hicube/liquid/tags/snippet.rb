module Hicube
  module Liquid
    module Tags
      class SnippetTag < ::Liquid::Tag

        def initialize(tag_name, variables, tokens)
          @variables = variables.split(" ")
          @snippet_name = @variables[0]
          super
        rescue
        end

        def render(context)
          unless @snippet_name.nil?
            puts "Context/Account is #{context['account']}"
            
            @snippet = Hicube::Snippet.find_by(name: @snippet_name, account: context['account'])
            ::Liquid::Template.parse(@snippet.body).render
          else
            "snippet_not_found for name #{name} and #{context['account']}"
          end
        rescue
          "snippet_not_found for name #{name} and #{context['account']}"
        end
      end

      ::Liquid::Template.register_tag('snippet_tag', SnippetTag)

    end
  end
end 