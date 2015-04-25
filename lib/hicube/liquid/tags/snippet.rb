module Hicube
  module Liquid
    module Tags
      class SnippetTag < ::Liquid::Tag

        # Convention for snippet is 
        # Variable[0] - snippet name
        # Variable[odd] - Name of liquid variable
        # Variable[even] - Value of liquid variable

        def initialize(tag_name, variables, tokens)
          @variables = variables.split(" ")
          @snippet = Hicube::Snippet.find_by(name: @variables[0])
          super
        rescue
        end

        def render(context)
          unless @snippet.nil?
            @snippet.body
            # @template = ::Liquid::Template.parse(@snippet.body)
            # if @variables.length > 1
            #   @template.render @variables[1] => context[@variables[2].strip]

            #   # FIXME: Handle passing more than one variable
              
            # else
            #   @template.render
            # end
          else
            "snippet_not_found"
          end
        end
      end

      ::Liquid::Template.register_tag('snippet_tag', SnippetTag)

    end
  end
end 