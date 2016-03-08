module Hicube
  class Account
    
    include Mongoid::Document
    include Mongoid::Timestamps

    # Associations
    #
    has_many :pages, class_name: 'Hicube::Page'
    has_many :snippets, class_name: 'Hicube::Snippet'
    has_many :documents, class_name: 'Hicube::Document'
    has_many :tags, class_name: 'Hicube::Document'

    #
    # Fields
    #
    field :ga, type: String

    field :notify_email_text, type: String

    field :notify_email_html, type: String

    field :domain, type: String

    validates_presence_of :ga, :domain #, :notify_email_html, :notify_email_text
    validates_uniqueness_of :domain

  end
end
