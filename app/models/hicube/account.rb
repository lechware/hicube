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

    field :domain, type: String

    validates_presence_of :ga, :domain #, :notify_email_html, :notify_email_text


  end
end
