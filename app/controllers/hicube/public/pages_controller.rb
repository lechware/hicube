module Hicube
  class Public::PagesController < Public::BaseController

    before_action :load_resource

    def show
      @template = ::Liquid::Template.parse(@page.body)
      @page_content = @template.render 'images' => Hicube::Document.images.all, 'documents' => Hicube::Document.files.all
    end
  end
end
