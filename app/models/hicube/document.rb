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
    # Scopes
    #
    scope :files, -> { where(:file.ne => nil) }
    scope :images, -> { where(:image.ne => nil) }

  end
end
