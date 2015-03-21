module Hicube
  class Account
    
    include Mongoid::Document
    include Mongoid::Timestamps

    #
    # Constant
    #

    #
    # Fields
    #
    field :ga, type: String

    # FIXME: Validation that ga entry is only one and unique


  end
end
