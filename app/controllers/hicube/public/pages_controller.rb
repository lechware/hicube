module Hicube  
  class Public::PagesController < Public::BaseController

    skip_before_filter :verify_authenticity_token
    before_action :load_resource, except: [:mail]

    def show
      filename = "#{Rails.root}/tmp/#{@page}_#{Process.pid}.slim"
      
      f = File.new(filename, "w+")
      f.write ::Liquid::Template.parse(@page.body).render
      f.close

      @page_content = ::Slim::Template.new(filename).render Object.new, links: Hicube::Page.parents.map(&:slug), documents: Hicube::Document.all, id: @page.slug
      # @header = ::Liquid::Template.parse(@page.header).render
      # @page_content = @template.render 'images' => Hicube::Document.images.all, 'documents' => Hicube::Document.files.all
    rescue Exception => e
      logger.error "Error: Rendering #{@page} failed."
      logger.error e
    end

    def mail
      PageMailer.notify(page_params).deliver_now
      if params[:page].has_key?(:success_page)
        redirect_to "/#{params[:page][:success_page]}"
      else
        redirect_to :back, flash: {success: "Message Sent! We will be in touch shortly."}
      end
    rescue
      redirect_to :back
    end

    def edit
      filename = "#{Rails.root}/tmp/#{@page}_#{Process.pid}.slim"
      
      f = File.new(filename, "w+")
      f.write ::Liquid::Template.parse(@page.body).render
      f.close

      @page_content = ::Slim::Template.new(filename).render Object.new, links: Hicube::Page.parents.map(&:slug), documents: Hicube::Document.all, id: @page.slug
  
    end

    private

    def page_params
      params.require(:page).permit(:subject, :name, :reply_to, :phone, :message)
    end
  end
end
