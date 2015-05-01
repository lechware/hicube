module Hicube
  class PageMailer < Hicube::ApplicationMailer

    def notify(options = {})
      logger.debug "Sending contact-form email using option - #{options}"
      @name = options[:name]
      @phone = options[:phone]
      @message = options[:message]
      mail(reply_to: options[:reply_to], subject: options[:subject])
    end

  end
end
