class Error
  include Mongoid::Document
  include Mongoid::Timestamps

  field :msg, type: String

end
