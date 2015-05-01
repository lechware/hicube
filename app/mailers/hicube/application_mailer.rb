module Hicube
  class ApplicationMailer < ActionMailer::Base
    default from: ENV['DEFAULT_FROM_EMAIL'], 
            to: ENV['DEFAULT_TO_EMAIL']
            
    layout 'mailer'
  end
end
