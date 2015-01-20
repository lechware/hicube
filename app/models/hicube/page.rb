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

    field :jt, type: Boolean, # Saving as String, so don't have to do transalation from String to Boolean in controller
      as:             :junction,
      default:        false

    # SEO settings

    # Validations
    validates_presence_of :title

    #
    # Scopes
    #
    default_scope -> {where(junction: false)}

    def junction?
      self.junction
    end

  end
end
