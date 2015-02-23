module Hicube
  class Snippet

    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, type: String

    field :bd, type: String,
      as:             :body

    # Validations
    validates_presence_of :name
    validates_presence_of :body

  end
end
