module Hicube
  class Snippet

    include Mongoid::Document
    include Mongoid::Timestamps

    # Association
    belongs_to :account, class_name: 'Hicube::Account'

    field :name, type: String

    field :bd, type: String,
      as:             :body

    # Validations
    validates_presence_of :name
    validates_presence_of :body

    def to_s
      self.name
    end
  end
end
