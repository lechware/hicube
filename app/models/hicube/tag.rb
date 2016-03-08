module Hicube
  class Tag

    include Mongoid::Document
    include Mongoid::Timestamps

    #
    # Relations
    #
    belongs_to :account, class_name: 'Hicube::Account'
    has_and_belongs_to_many :documents, class_name: 'Hicube::Document'

    field :n, type: String,
      as:           :name
    
    def to_s
      self.name
    end
  end
end
