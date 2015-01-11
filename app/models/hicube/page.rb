module Hicube
  class Page
  
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Slug

    #
    # Slugs
    #
    slug              :title

    field :tt, type: String,
      as:             :title


    field :bd, type: String,
      as:             :body

    # SEO settings

    # Validations
    validates_presence_of :title

    # def to_param
    #   self.title
    # end
  end
end
