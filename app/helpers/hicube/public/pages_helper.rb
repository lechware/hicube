module Hicube
  module Public::PagesHelper
    
    def active?(options = {})
      logger.debug "Setting active class for div with paths - #{options}"
      options.each do |o|
        case
        when current_page?(o)
          return :active
        end
      end
    end

    # def header_links
    #   Hicube::Page.parents
    # end    
  
  end
end
