require_dependency "hicube/base_controller"

module Hicube
  class PagesController < BaseController
    
    before_action :load_resource, except: [
      :create,
      :index,
      :new
    ]

    before_filter :load_resources, :only => [
      :index,
    ]

    # Must be called after load_recource filter.
    before_filter :check_resource_params, :only => [
      :create,
      :update,
    ]

    def create
      logger.debug "Creating page with #{params}"
      @page = Hicube::Page.new page_params
      @page.seo_title = "#{app_name} - #{@page.title}" if (@page.seo_title.nil? or @page.seo_title.empty?)
      @page.save!

      
      respond_to do |format|
        notify :notice, ::I18n.t('messages.resource.created',
          :type       => Hicube::Page.model_name.human,
          :resource   => @page
        )
        format.html { redirect_to action: :edit, id: @page }
      end
    rescue Mongoid::Errors::Validations => e
      respond_to do |format|
        notify_now :error, ::I18n.t('messages.resource.not_valid',
          :type     => Hicube::Page.model_name.human,
          :errors   => @page.errors.full_messages.to_sentence
        )
        format.html { render :action => :new, :status => 422 }
      end
    end

    def edit
    end

    def new
    end

    def update
      logger.debug "Updating Pages with #{params}"
      @page.update_attributes page_params
      @page.seo_title = "#{app_name} - #{@page.title}" if (@page.seo_title.nil? or @page.seo_title.empty?)
      
      @page.save!
        
      respond_to do |format|
        notify :notice, ::I18n.t('messages.resource.updated',
          :type       => Hicube::Page.model_name.human,
          :resource   => @page
        )
        format.html { redirect_to action: :edit, id: @page }
      end
    rescue Mongoid::Errors::Validations => e
      respond_to do |format|
        notify_now :error, ::I18n.t('messages.resource.not_valid',
          :type     => Hicube::Page.model_name.human,
          :errors   => @page.errors.full_messages.to_sentence
        )
        format.html { render :action => :edit, id: @page, :status => 422 }
      end
    end

    private

    def page_params
      # This is bit of a hack, if name is empty then do not try and save content as it will fail
      params[:page][:content_attributes].reject! { |k,v| v[:name].empty? and v[:head] } rescue
      logger.debug "Page after removing unwanted head content #{params}"

      params.require(:page).permit(:title, :parent, :body, :seo_title, :seo_keywords, :seo_description, content_attributes: [:id, :name, :body, :head, :_destroy])
    end
  
  end
end