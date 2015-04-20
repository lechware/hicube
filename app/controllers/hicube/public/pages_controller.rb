module Hicube
  class Public::PagesController < Public::BaseController

    before_action :load_resource, except: [:mail]

    def show
      @template = ::Liquid::Template.parse(@page.body)
      @page_content = @template.render 'images' => Hicube::Document.images.all, 'documents' => Hicube::Document.files.all
    end

    def mail
      PageMailer.contact_form(page_params).deliver_now
      redirect_to :back, flash: {success: "Message Sent! We will be in touch shortly."}
    rescue
      redirect_to :back
    end

    private

    def page_params
      params.require(:page).permit(:to, :subject, :name, :email, :phone, :message)
    end
  end
end
