require_dependency "hicube/application_controller"

module Hicube
  class DocumentsController < BaseController

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
      @document = Document.new document_params.except(:tags)
      @document.account = current_account
      document_params[:tags].split(' ').each do |s|
        @document.tags << Hicube::Tag.find_or_create_by(name: s, account: current_account)
      end

      @document.save!

      respond_to do |format|
        notify :notice, ::I18n.t('messages.resource.created',
          type:       Hicube::Document.model_name.human,
          resource:   @document
        )
        format.html { redirect_to action: :index }
      end
    end

    def destroy
      @document.destroy

      respond_to do |format|
        notify :warning, ::I18n.t('messages.resource.destroyed',
          type:       Hicube::Document.model_name.human,
          resource:   @document
        )
        format.html { redirect_to action: :index }
      end
    end

    def edit
    end
    
    def index
    end

    def show
    end
    
    def update  
      @document.update_attributes document_params.except(:tags)
      
      @document.tags = nil
      params[:document][:tags].split(' ').each do |s|
        @document.tags << Hicube::Tag.find_or_create_by(name: s, account: current_account)
      end

      @document.save!

      respond_to do |format|
        notify :notice, ::I18n.t('messages.resource.updated',
          type:       Hicube::Document.model_name.human,
          resource:   @document
        )
        format.html { redirect_to action: :index }
      end
     end
    
    private

    def document_params
      params.require(:document).permit(:name, :file, :tags)
    end
  end
end
