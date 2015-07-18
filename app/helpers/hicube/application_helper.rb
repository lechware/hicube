module Hicube
  module ApplicationHelper

    def heading
      if current_page?(action: :new)
        'New'
      else
        instance_variable_get("@#{controller_name.singularize}") || controller_name.camelize
      end
    end

    def subheading
      return if controller_name.eql?('dashboards')
      controller_name.singularize.camelize unless current_page?(action: :index)
    end

    def breadcrumbs
      return [] if controller_name.eql?('dashboards')
      case
      when current_page?(action: :index)
        { controller_name.camelize => {path: nil, active: true} }
      when current_page?(action: :new)
        {
          controller_name.camelize => {path: url_for(controller: controller_name, action: :index), active: false},
          'New' => {path: nil, active: true}
        }
      else # show & edit
        {
          controller_name.camelize => {path: url_for(controller: controller_name, action: :index), active: false},
          instance_variable_get("@#{controller_name.singularize}") => {path: nil, active: true}
        }
      end
    end

    def sidebar_class(action, model, options = {})
      case action
      when :edit, :new
        if options.nil?
          current_page?(eval("#{action}_#{model}_path")) ? :active : nil rescue nil # for edit
        else
          current_page?(eval("#{action}_#{model}_path(options)")) ? :active : nil rescue nil # for edit
        end
      when :index
        current_page?(eval("#{model.to_s.pluralize}_path")) ? :active : nil
      when :show
        if options.nil?
          current_page?(eval("#{model}_path")) ? :active : nil rescue nil
        else
          current_page?(eval("#{model}_path(options)")) ? :active : nil rescue nil
        end        
      else
        nil
      end
    end

    def root_path
      '/'
    end

    def header_links
      Hicube::Page.parents
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
