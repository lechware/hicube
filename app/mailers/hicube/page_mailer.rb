module Hicube
  class PageMailer < Hicube::ApplicationMailer

    def contact_form(options = {})
      logger.debug "Sending contact-form email using option - #{options}"
      @name = options[:name]
      @phone = options[:phone]
      @message = options[:message]
      mail(from: options[:from], to: options[:to], reply_to: options[:email], subject: options[:subject])
    end

  end
end
