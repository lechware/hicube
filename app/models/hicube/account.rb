module Hicube
  class Account
    
    include Mongoid::Document
    include Mongoid::Timestamps

    #
    # Constant
    #

    #
    # Fields
    #
    field :ga, type: String

    field :notify_email_text, type: String

    field :notify_email_html, type: String

    validates_presence_of :ga #, :notify_email_html, :notify_email_text


  end
end
