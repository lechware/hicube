require_dependency "hicube/application_controller"

module Hicube
  class ContentsController < BaseController

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

    def update
      logger.debug "Updating Pages with #{params}"
      @content.update_attributes content_params

      @content.save!
      respond_to do |format|
        format.json { render json: true }
      end
    rescue Mongoid::Errors::Validations => e
      respond_to do |format|
        format.json { render json: false }
      end 
    end

    private

    def content_params
      params.require(:content).permit(:name, :body)
    end

    # Nested attributes are currently not handled in basecontroller
    def load_resource
      @page = Hicube::Page.find(params[:page_id])
      @content = @page.content.find_or_create_by(name: params[:id])
    end

    def load_resources

    end

  end
end
