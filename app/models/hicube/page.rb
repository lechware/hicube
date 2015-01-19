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

    field :jt, type: Boolean,
      as:             :junction,
      default:        false

    # SEO settings

    # Validations
    validates_presence_of :title

    #
    # Scopes
    #
    default_scope -> {where(junction: false)}
    
    # def to_param
    #   self.title
    # end
  end
end
