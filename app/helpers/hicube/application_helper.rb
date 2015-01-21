module Hicube
  module ApplicationHelper

    def body_class
      params[:controller].include?('devise') ? 'bg-black' : 'skin-blue'
    end

    def root_path
      '/'
    end

    def header_links
      Hicube::Page.parents
    end

    def active_link?(path)
      current_page? path
    end
  end
end
