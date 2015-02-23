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

    def snippet_render(name)
      snippet = Hicube::Snippet.find_by(name: name)
      raw "#{Hicube::Markdown.render(::Liquid::Template.parse(snippet.body).render).html_safe}"
    rescue Mongoid::Errors::DocumentNotFound => dnf
      raw "Snippet Not found with name #{name}"
    rescue Exception => e
      raw "#{e}"
    end
  end
end
