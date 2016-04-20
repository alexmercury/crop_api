class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :uid, type: String

  index({ uid: 1 }, { unique: true, name: 'uid_index' })

  has_many :videos

  before_save :generate_uid

  private

    def generate_uid
      self.uid = SecureRandom.hex(12)
    end

end
