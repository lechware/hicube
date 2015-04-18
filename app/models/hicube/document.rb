module Hicube
  class Document

    include Mongoid::Document
    include Mongoid::Timestamps
    
    #
    # Relations
    #
    has_and_belongs_to_many :tags, class_name: 'Hicube::Tag'

    #
    # Uploaders
    #
    mount_uploader :file, FileUploader
    mount_uploader :image, ImageUploader

    #
    # Fields
    #
    field :n, type: String,
      as:           :name
    validates_presence_of :name
    validates_uniqueness_of :name,
      allow_blank:          :false,
      message:              'is not unique or cannot be blank'

    #
    # Scopes
    #
    scope :files, -> { where(:file.ne => nil) }
    scope :images, -> { where(:image.ne => nil) }

    def to_s
      self.name
    end

    def to_liquid
      {
        'url' => (self.image.nil? ? self.file_url : self.image_url),
        'tags' => self.tags.map(&:name)
      }
    end

  end
end
