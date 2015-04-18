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
      document_params[:tags].split(' ').each do |s|
        @document.tags << Hicube::Tag.find_or_create_by(name: s)
      end

      @document.save!

      respond_to do |format|
        notify :notice, ::I18n.t('messages.resource.created',
          type:       Hicube::Document.model_name.human,
          resource:   @document
        )
        if params[:document].has_key? :image
          format.html { redirect_to action: :index, image: true }
        else
          format.html { redirect_to action: :index }
        end
      end
    end

    def destroy
      img = @document.image?
      @document.destroy

      respond_to do |format|
        notify :warning, ::I18n.t('messages.resource.destroyed',
          type:       Hicube::Document.model_name.human,
          resource:   @document
        )
        if img
          format.html { redirect_to action: :index, image: true }
        else
          format.html { redirect_to action: :index }
        end
      end
    end

    def edit
    end
    
    def index
      @documents = params.has_key?(:image) ? @documents.images : @documents.files
    end

    def show
    end
    
    def update  
      @document.update_attributes document_params.except(:tags)
      
      @document.tags = nil
      params[:document][:tags].split(' ').each do |s|
        @document.tags << Hicube::Tag.find_or_create_by(name: s)
      end

      @document.save!

      respond_to do |format|
        notify :notice, ::I18n.t('messages.resource.updated',
          type:       Hicube::Document.model_name.human,
          resource:   @document
        )
        if params[:document].has_key? :image
          format.html { redirect_to action: :index, image: true }
        else
          format.html { redirect_to action: :index }
        end
      end
     end
    
    private

    def document_params
      params.require(:document).permit(:name, :image, :file, :tags)
    end
  end
end
