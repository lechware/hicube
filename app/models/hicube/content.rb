module Hicube
  class Content

    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Slug

    #
    # Slugs
    #
    slug              :name

    #
    # Relations
    #
    embedded_in :page, class_name: 'Hicube::Page'

    field :name, type: String
    field :body, type: String

    validates_presence_of :name
    validates_uniqueness_of :name

    def to_s
      self.name
    end

  end
end
