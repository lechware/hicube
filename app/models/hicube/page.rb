module Hicube
  class Page
  
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Slug

    #
    # Slugs
    #
    slug              :title

    #
    #
    #
    has_many :children, class_name: 'Hicube::Page'
    belongs_to :parent, class_name: 'Hicube::Page'
    embeds_many :content, class_name: 'Hicube::Content'
    
    field :tt, type: String,
      as:             :title

    field :bd, type: String,
      as:             :body

    # field :jt, type: Boolean, # Saving as String, so don't have to do transalation from String to Boolean in controller
    #   as:             :junction,
    #   default:        false

    # SEO settings

    # Validations
    validates_presence_of :title
    validates_uniqueness_of :title, scope: :parent

    #
    # Scopes
    #
    default_scope -> { ne(_slugs: ["index"]) }
    scope :parents, -> { where(parent: nil) }

    def to_s
      self.title
    end

    def junction?
      !(self.children.nil? or self.children.empty?)
    end

    def child?
      !self.parent.nil? and self.parent.present?
    end
  end
end
