require_dependency "hicube/base_controller"

module Hicube
  class SnippetsController < BaseController

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
      logger.debug "Creating snippet with #{params}"
      @snippet = Hicube::Snippet.new snippet_params
      @snippet.save!
    
      respond_to do |format|
        notify :notice, ::I18n.t('messages.resource.created',
          :type       => Hicube::Snippet.model_name.human,
          :resource   => @snippet
        )
        format.html { redirect_to action: :index }
      end
    rescue Mongoid::Errors::Validations => e
      respond_to do |format|
        notify_now :error, ::I18n.t('messages.resource.not_valid',
          :type     => Hicube::Snippet.model_name.human,
          :errors   => @snippet.errors.full_messages.to_sentence
        )
        format.html { render :action => :new, :status => 422 }
      end
    end

    def edit
    end

    def index
    end
    
    def new
    end

    def update
      logger.debug "Updating snippets with #{params}"
      @snippet.update_attributes snippet_params

      @snippet.save!
        
      respond_to do |format|
        notify :notice, ::I18n.t('messages.resource.updated',
          :type       => Hicube::Snippet.model_name.human,
          :resource   => @snippet
        )
        format.html { redirect_to action: :index }
      end
    rescue Mongoid::Errors::Validations => e
      respond_to do |format|
        notify_now :error, ::I18n.t('messages.resource.not_valid',
          :type     => Hicube::Snippet.model_name.human,
          :errors   => @snippet.errors.full_messages.to_sentence
        )
        format.html { render :action => :new, :status => 422 }
      end
    end

    private

    def snippet_params
      params.require(:snippet).permit(:name, :body)
    end

  end
end
